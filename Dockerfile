FROM python:3.9
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Use the recommended HF_HOME instead of deprecated TRANSFORMERS_CACHE
ENV HF_HOME=/code/cache/huggingface

# Create the directory for the Transformers cache and set permissions
RUN mkdir -p /code/cache/huggingface && chmod -R 777 /code/cache/huggingface

COPY . /app

EXPOSE 7860
# Increase Gunicorn timeout to prevent worker timeout during long initializations
CMD ["gunicorn", "-b", "0.0.0.0:7860", "main:app", "--timeout", "120", "--workers", "2", "--threads", "2"]


# # Use an official Python runtime as a base image
# FROM python:3.9

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container at /app
# COPY ./requirements.txt /code/requirements.txt

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# # Define environment variable for the Hugging Face home
# # ENV HF_HOME=/app/cache/huggingface
# ENV HF_HOME=/code/cache/huggingface


# # Create the directory for the Transformers cache and set permissions
# RUN mkdir -p /code/cache/huggingface && chmod -R 777 /code/cache/huggingface


# # # Create the directory for the Hugging Face cache
# # RUN mkdir -p $HF_HOME
# # Optional: Adjust permissions if necessary
# # RUN chmod 755 $HF_HOME

# # Copy the rest of your application's code into the container at /app
# # COPY . /app
# COPY . .

# # Define environment variable for the Flask application port
# # ENV PORT=8080

# # # Expose the port the application runs on
# # EXPOSE 7860
# CMD ["panel", "server", "/code/app/py", "--address","0.0.0.0","--port", "7860" "--allow-websocket-origin","pankaj100567-Textsimilarity-str`"]

# CMD ["gunicorn", "-b", "0.0.0.0:7860", "main:app"]

# Run app.py when the container launches
# CMD ["python", "app.py", "--allow-websocket-origin","pankaj100567-Textsimilarity-str.hf.space"]
# CMD ["python", "app.py", "--allow-websocket-origin","pankaj100567-Textsimilarity-str.hf.space"]



# # Use an official Python runtime as a base image
# FROM python:3.9

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container at /app
# COPY requirements.txt /app/requirements.txt

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Define environment variable for the Transformers cache
# ENV TRANSFORMERS_CACHE=/app/cache/huggingface

# # Create the directory for the Transformers cache
# RUN mkdir -p /app/cache/huggingface && chmod 777 /app/cache/huggingface

# # Copy the rest of your application's code into the container at /app
# COPY . /app

# # Define environment variable for the Flask application port
# ENV PORT=8080

# # Expose the port the application runs on
# EXPOSE 8080

# # Run app.py when the container launches
# CMD ["python", "app.py"]


# # Use an official Python runtime as a base image
# FROM python:3.9

# # Set the working directory in the container
# WORKDIR /app

# # Copy the requirements file into the container at /app
# COPY requirements.txt /app/requirements.txt

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Copy the rest of your application's code into the container at /app
# COPY . /app

# # Define environment variable
# ENV PORT 8080

# # Run app.py when the container launches
# CMD ["python", "app.py"]


# FROM python:3.9


# WORKDIR /code

# COPY ./requirements.txt /code/requirements.txt

# RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# COPY . .

# CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "7860"]

# # Use an official Python runtime as a parent image
# FROM python:3.9

# # Set the working directory in the container
# WORKDIR /code

# # Copy the dependencies file to the working directory
# COPY requirements.txt /code/

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir --upgrade -r requirements.txt

# # Copy the current directory contents into the container at /code
# COPY . /code/

# # Make port 5000 available to the world outside this container
# EXPOSE 5000

# # Define environment variable
# ENV FLASK_APP=app.py
# ENV FLASK_RUN_HOST=0.0.0.0
# ENV FLASK_RUN_PORT=5000

# # Run the application when the container launches
# # CMD ["flask", "run"]

# CMD ["flask","run","panel","server","--allow-websocker-origin","pankaj100567-similarity-measure.hf.space"]
