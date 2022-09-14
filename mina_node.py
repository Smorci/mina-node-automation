import sys

print("Script started")

tfProjectVars = {
  "id": "",
  "region": "",
  "zone": "",
  "credentials": ""
}

for key in tfProjectVars:
  if key != "credentials":
    tfProjectVars[key] = input("Please enter your Google Cloud project " + key + ":\n")
  else:
    tfProjectVars[key] = input("Please enter the ABSOLUTE path to your Google Cloud project credentials:\n")

