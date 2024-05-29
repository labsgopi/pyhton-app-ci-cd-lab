# Use a Python 3 base image
FROM python:3.9-slim

# Install pip (already included in Python 3 image)
# RUN pip install --upgrade pip  # No need for upgrade if using a recent image

# Install Python modules
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy application files
COPY app.py /usr/src/app/
COPY index.html /usr/src/app/templates/
COPY styles.css /usr/src/app/templates/

# Expose port
EXPOSE 5000

# Run the application
CMD ["python", "/usr/src/app/app.py"]

