import socket

def test_port(host, port):
    """
    Tests the connectivity to a specific port on a given host.

     parameter host: The hostname or IP address to test.
     parameter port: The port number to test.

    """
    print(f"Testing connectivity to {host}:{port}")

    # Create a socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

    # Attempt to connect to the host and port
    result = sock.connect_ex((host, port))

    # Check if the connection was successful
    if result == 0:
        print(f"Port {port} on {host} is open.\n")
    else:
        print(f"Port {port} on {host} is closed.\n")

    # Close the socket
    sock.close()


# You can test other ports by calling the function with different port numbers:
# test_port('portport.com', 80)   # HTTP
# test_port('portport.com', 22)   # SSH
# test_port('portport.com', 21)   # FTP
# test_port('portport.com', 25)   # SMTP
# test_port('portport.com', 53)   # DNS

# Example: Testing HTTPS port (443)
test_port('portport.com', 443)


