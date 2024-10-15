# Ruby Code Challenge

# Introduction

This repsetive provide project contains a Ruby script (`challenge.rb`) that processes by loading the respective user & company data from `users.json` and `companies.json`.
The script calculates token top-ups for active users based on their company’s top-up value and generates an `output.txt` file with the respective results.

# Key Features:

- Calculates and updates token balances for active users.
- Differentiates between users who should receive an email and those who should not based on company and user email status.
- Outputs the result in the format specified in the `example_output.txt`.
- Handles potential bad data by safely fetching fields with default values to avoid crashes.

# Files

- `challenge.rb`: Main Ruby script that processes the JSON data which includes all the respective code for assessment.
- `users.json`: The respective data/source file contains user information, including token balances, email status, and active status.
- `companies.json`: The respective data/source file contains company information, that includes token top-up amounts and email status.
- `output.txt`: Generated output file after running the script.
- `example_output.txt`: Sample output file provided for reference.

## Requirements

- Ruby 3.x or later.
- VS code or any code editor

# How to Run the Script

1. **Clone the repository**:
   ```bash
   git clone <https://github.com/mounikkama/Ruby
   cd Ruby
   ```
2. **Run the code**:
   ruby challenge.rb
