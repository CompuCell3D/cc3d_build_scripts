import subprocess
import sys
import os
from pathlib import Path
from datetime import datetime


def get_timestamp():
    """
    Returns the current timestamp in the format YYYY-MM-DD HH:MM:SS.
    """
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def parse_command_line_args():
    """
    Parses the command-line arguments and ensures a valid command is provided.
    Returns the parsed command as a list of arguments.
    """
    if len(sys.argv) < 2:
        print("Usage: python log_and_display.py \"command with arguments\"")
        sys.exit(1)

    # Combine all arguments into a single command string
    command = sys.argv[1:]

    # If the command is a single string, split it manually; otherwise, keep it as-is
    if len(command) == 1:
        parsed_command = command[0].split()  # Split by spaces
    else:
        parsed_command = command

    # Resolve absolute paths for better compatibility
    parsed_command[0] = os.path.abspath(parsed_command[0])

    return parsed_command


def execute_command(command, log_file):
    """
    Executes the given command and logs its output with timestamps to the console and a file.
    """
    with open(log_file, "a", buffering=1) as f:
        try:
            # Run the command as a subprocess
            process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)

            # Read output from the process line by line
            for line in process.stdout:
                timestamped_line = f"[{get_timestamp()}] {line}"  # Add timestamp to the line
                sys.stdout.write(timestamped_line)  # Print to the console
                f.write(timestamped_line)  # Append to the log file

            # Wait for the process to complete and get its exit code
            process.wait()
        except FileNotFoundError as e:
            error_message = f"[{get_timestamp()}] Error: {e}\n"
            sys.stdout.write(error_message)
            f.write(error_message)
            sys.exit(1)
        except Exception as e:
            error_message = f"[{get_timestamp()}] Unexpected error: {e}\n"
            sys.stdout.write(error_message)
            f.write(error_message)
            sys.exit(1)

    # Exit with the same code as the subprocess
    sys.exit(process.returncode)


def main():
    """
    Main function that orchestrates the execution of the script.
    """
    # Specify the log file

    log_file =  Path(__file__).parent.joinpath("install.log")

    # Parse the command-line arguments
    command = parse_command_line_args()

    print(f"Command: {command}")

    # Execute the command and log output
    execute_command(command, log_file)


if __name__ == "__main__":
    main()
