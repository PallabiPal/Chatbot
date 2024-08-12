'''from flask import Flask, render_template, request, jsonify
from chat import get_response

app = Flask(__name__)

@app.route("/", methods=["GET"])
def get_bot_response(text):
    msg = request.args.get("msg")
    print(type(msg))  # Add this line to see the type of msg
    if not msg or not (isinstance(msg, str) or isinstance(msg, bytes)):
        return jsonify({"error": "Invalid message"}), 400
    response = get_response(msg.decode() if isinstance(msg, bytes) else msg)  # Call your chatbot's response function
    return jsonify({"response": response})

def index_get():
    return render_template("index.html")

@app.post("/predict")
def predict():
    text = request.get_json().get("message")
    response = get_response(text)
    message = {"answer": response}
    return jsonify(message)'''

'''from flask import Flask, render_template, request
import json
import random

app = Flask(__name__)

# Load the JSON file containing the responses
with open('intents.json') as f:
    data = json.load(f)

# Define a function to get the response from the JSON file
def get_response(user_text):
    user_text = user_text.lower()
    for intent in data['intents']:
        for pattern in intent['patterns']:
            if pattern.lower() in user_text:
                response = random.choice(intent['responses'])
                return response
    return "Sorry, can't understand you. Please try again."

#define app routes
@app.route("/")
def index():
    return render_template("index.html")

@app.route("/get")
#function for the bot response
def get_bot_response():
    user_text = request.args.get('msg')
    return get_response(user_text)

if __name__ == "__main__":
    app.run(port=5002)'''



from flask import Flask, render_template, request,jsonify
import pyodbc

app = Flask(__name__)

# Define the database connection settings
server = 'DESKTOP-JE09TUR\SQLEXPRESS'
database = 'information'

# Create a connection to the database
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';Trusted_Connection=yes')

# Define a function to get the response from the database
def get_response(user_text):
    print('User text: ',user_text)
    user_text = user_text.lower()
    if user_text == "existing password ":
        #print("Returning existing password response")
        return "Please enter your login ID as login id: "
        #return "Please enter your login ID: "
    elif user_text=="generate a strong password":
        return "<a href='https://passwordgenerator.org/' target='_blank'>Generate a strong password</a>"
    elif user_text=="TICKET RAISE":
        return "Please enter your mobile no."
    else:
        # existing code for handling other user inputs
        print("Querying database...")
        cursor = cnxn.cursor()
        query = "SELECT response, has_options FROM chatbot_responses WHERE question LIKE '%" + user_text + "%' ORDER BY NEWID()"
        cursor.execute(query)
        row = cursor.fetchone()
        if row:
            response, has_options = row
            if has_options:
                # Retrieve options from chatbot_options table
                cursor.execute("SELECT option_text FROM chatbot_options WHERE response_id IN (SELECT id FROM chatbot_responses WHERE question LIKE '%" + user_text + "%')")
                options = [option[0] for option in cursor.fetchall()]
                return response#"Here are your options:\n" + "\n".join([f"{i+1}. {option}" for i, option in enumerate(options)])
            else:
                # Return the response
                return response
        return "Sorry, can't understand you. Please try again."
    '''user_text = user_text.lower()
    cursor = cnxn.cursor()
    query = "SELECT response, has_options FROM chatbot_responses WHERE question LIKE '%" + user_text + "%' ORDER BY NEWID()"
    cursor.execute(query)
    row = cursor.fetchone()
    if row:
        response, has_options = row
        if has_options:
            # Retrieve options from chatbot_options table
            cursor.execute("SELECT option_text FROM chatbot_options WHERE response_id IN (SELECT id FROM chatbot_responses WHERE question LIKE '%" + user_text + "%')")
            options = [option[0] for option in cursor.fetchall()]
            return "Here are your options:\n" + "\n".join([f"{i+1}. {option}" for i, option in enumerate(options)])
        else:
            # Return the response
            return response
    return "Sorry, can't understand you. Please try again."'''
    #user_text = user_text.lower()
    #cursor = cnxn.cursor()
    #query = "SELECT response FROM chatbot_responses WHERE question LIKE '%" + user_text + "%' ORDER BY NEWID()"
    #cursor.execute(query)
    #row = cursor.fetchone()
    #if row:
        #return row[0]
    #return "Sorry, can't understand you. Please try again."

#define app routes
@app.route("/")
def index():
    return render_template("index.html")

@app.route("/get")
#function for the bot response
#def get_bot_response():
    #user_text = request.args.get('msg')
    #return get_response(user_text)

def get_bot_response():
    '''user_text = request.args.get('msg')
    response = get_response(user_text)
    has_options = 0
    options = []
    cursor = cnxn.cursor()
    query = "SELECT has_options FROM chatbot_responses WHERE question LIKE '%" + user_text + "%'"
    cursor.execute(query)
    row = cursor.fetchone()
    if row:
        has_options = row[0]
        if has_options:
            query = "SELECT option_text FROM chatbot_options WHERE response_id IN (SELECT id FROM chatbot_responses WHERE question LIKE '%" + user_text + "%')"
            cursor.execute(query)
            rows = cursor.fetchall()
            for row in rows:
                options.append(row[0])
    return jsonify({'response': response, 'has_options': has_options, 'options': options})'''
    
    user_text = request.args.get('msg')
    #user_text = request.args.get('msg')
    if user_text.lower() == "hello":
        response = "How can I assist you today?"
        has_options = 1
        options = []
        cursor = cnxn.cursor()
        query = "SELECT option_text FROM chatbot_options WHERE response_id IN (SELECT id FROM chatbot_responses WHERE question LIKE '%hello%')"
        cursor.execute(query)
        rows = cursor.fetchall()
        for row in rows:
            options.append(row[0])
        return jsonify({'response': response, 'has_options': has_options, 'options': options})
    elif user_text.lower() == "existing password":
        return jsonify({'response': "Please enter your login ID to retrieve your password. Write login id: "})
    #elif user_text.lower().startswith("login id: "):
        #login_id = user_text.lower().replace("login id: ", "")
    elif user_text.lower()=="ticket raise":
        mobile_no= request.args.get('mobile_no')
        if mobile_no:
            cursor=cnxn.cursor()
            query = "INSERT INTO ticket (mobile_no) VALUES (?)"
            cursor.execute(query, (mobile_no,))
            cnxn.commit()
            ticket_id = cursor.execute("SELECT SCOPE_IDENTITY()").fetchone()[0]
            return jsonify({'response':"Your ticket is raised successfully.\n Your ticket id is {ticket_id}."})
        else:
            return jsonify({'response':"Please enter your mobile number."})
    elif user_text.isdigit():
        if len(user_text)==10:
            mobile_no=user_text
            cursor=cnxn.cursor()
            query = "INSERT INTO ticket (mobile_no) VALUES (?)"
            cursor.execute(query, (mobile_no,))
            cnxn.commit()
            ticket_id = cursor.execute("SELECT @@IDENTITY").fetchone()[0]
            return jsonify({'response':f"Your ticket is raised successfully.\n Your ticket id is {ticket_id}.\n Our team will contact you soon"})
        #else:
            #return jsonify({'response':"Please enter your mobile number."})'''
        elif len(user_text)==4:
            login_id = user_text
            cursor = cnxn.cursor()
            query = "SELECT password FROM users WHERE login_id =?"
            cursor.execute(query, (login_id,))
            row = cursor.fetchone()
            if row:
                password = row[0]
                return jsonify({'response': f"Your password is: {password}"})
            else:
                return jsonify({'response': "Login ID not found."})
        else:
            return jsonify({'response': "Please enter the no. correctly"})
            
    elif user_text.startswith("enquiry "):
        current_month = user_text.split(" ")[1].capitalize()
        cursor = cnxn.cursor()
        query = "SELECT current_month, financial_year, COUNT(*) as no_of_enquiry FROM enquiries WHERE current_month =? GROUP BY current_month, financial_year"
        cursor.execute(query, (current_month,))
        rows = cursor.fetchall()
        if rows:
            response = "<table border='1'><tr><th>Current Month</th><th>Financial Year</th><th>No. of Enquiry</th></tr>"
            for row in rows:
                response += "<tr><td>" + row[0] + "</td><td>" + str(row[1]) + "</td><td>" + str(row[2]) + "</td></tr>"
            response += "</table>"
            return jsonify({'response': response, 'has_options': 0, 'options': []})
        else:
            return jsonify({'response': "No enquiries found for " + current_month + ".", 'has_options': 0, 'options': []})
    else:
        response = get_response(user_text)
        has_options = 0
        options = []
        cursor = cnxn.cursor()
        query = "SELECT has_options FROM chatbot_responses WHERE question LIKE '%" + user_text + "%'"
        cursor.execute(query)
        row = cursor.fetchone()
        if row:
            has_options = row[0]
            if has_options:
                query = "SELECT option_text FROM chatbot_options WHERE response_id IN (SELECT id FROM chatbot_responses WHERE question LIKE '%" + user_text + "%')"
                cursor.execute(query)
                rows = cursor.fetchall()
                for row in rows:
                    options.append(row[0])
        return jsonify({'response': response, 'has_options': has_options, 'options': options})
if __name__ == "__main__":
    app.run(port=5002)
