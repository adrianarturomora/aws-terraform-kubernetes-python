from flask import Flask, request, jsonify

app = Flask(__name__)

def has_same_first_last_digit(x: int) -> bool:
    x = abs(x)
    last_digit = x % 10

    while x >= 10:
        x //= 10

    first_digit = x
    return first_digit == last_digit

@app.get("/health")
def health():
    return "ok", 200

@app.get("/check")
def check():
    # Example: /check?x=121
    x_str = request.args.get("x")

    if x_str is None:
        return jsonify({"error": "Missing query parameters 'x' (example: /check?x=121)"}), 400
    
    try:
        x = int(x_str)
    
    except ValueError:
        return jsonify({"error": "x must be an integer"}), 400
    
    return jsonify({
        "number": x,
        "first_equals_last": has_same_first_last_digit(x)
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)

