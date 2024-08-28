import reverb
import tensorflow as tf

# Define the client
client = reverb.Client(f'localhost:8888')

# Check if the client can connect to the server
print("Checking connection...")
if client.server_info():
    print("Connected to the Reverb server!")
else:
    print("Failed to connect to the Reverb server.")