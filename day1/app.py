from flask import Flask


app = Flask(__name__)

@app.route('/')
def hello_docker():
    return '<h1> This is Lilly john </h1><br><p>Starting Github action with Akhilesh....</p> '

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
