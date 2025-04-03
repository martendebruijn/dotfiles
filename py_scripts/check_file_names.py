import os
import re

def check_file_names(directory):
  pattern = r'^\d{4}-\d{2}-\d{2}-.*$' # yyyy=-mm-dd-*.*

  try:
    files = os.listdir(directory)
    invalid_files = []

    for filename in files:
      if not re.match(pattern, filename):
        invalid_files.append(filename)

    if invalid_files:
      print("Invalid file names")
      for file in invalid_files:
        print(f"- {file}")

    else:
      print("All file names are valid")
    
  except Exception as e:
    print(f"Error: {e}")

if __name__ == "__main__":
  directory = input("Enter directory path: ")
  check_file_names(directory)
