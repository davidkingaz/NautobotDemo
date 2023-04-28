# Dockerfile
FROM networktocode/nautobot:latest

# Copy the custom configuration file
COPY nautobot_config.py /opt/nautobot/nautobot_config.py
