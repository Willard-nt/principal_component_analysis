import subprocess
import os

# Define absolute paths to the Python files
python_files = [
    "./json_to_csv.py",
    "./clean_csv.py"
]

# Print the path to each script
print("Running the following scripts:")
for file in python_files:
    print(os.path.abspath(file))

# Execute each script
for file in python_files:
    subprocess.run(["python", file])
