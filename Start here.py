import subprocess

print("I hope that you have PowerShell installed")
directory = input("Write the directory that you want to keep organized: ")

with open("directory.txt", "w") as file:
    file.write(directory)


powershell_path = r'D:\Downloads-cleaner\script_windows.ps1'
powershell_command = f'powershell -ExecutionPolicy Bypass -File "{powershell_path}"'

try:
    subprocess.run(powershell_command, check=True, shell=True)
    print("PowerShell script executed successfully.")
except subprocess.CalledProcessError as e:
    print(f"Error executing PowerShell script: {e}")
