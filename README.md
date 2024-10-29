<img align="right" src="https://i.imgur.com/lFnPHJY.png" alt="Lethe" height="400"/>

# Lethe

**Lethe** is a cross-platform OCaml script designed to anonymize files in a specified directory by renaming them to random strings. Inspired by the mythological river of forgetfulness, Lethe erases identifiable information from files, ensuring greater privacy and security.

## Features

- **Random Renaming**: Each file in the target directory is renamed to a unique random string, preserving the original file extension.
- **Timestamp Handling**: The script updates the access and modification timestamps of each file to the current time. Additionally, by deleting the original file and creating a new one, it also sets the creation time to the moment of creation.
- **Cross-Platform Compatibility**: Works seamlessly on both Linux and Windows platforms.

## Usage

1. Ensure you have OCaml and Dune installed.
2. Clone the repository:

   ```bash
   git clone https://github.com/paulo-granthon/lethe
   cd lethe
   ```

3. Build the project using Dune:

   ```bash
   dune build
   ```

4. Run the script with the target directory as an argument:

   ```bash
   dune exec lethe path/to/directory
   ```

## Limitations

- **Large Files**: The current implementation reads the entire contents of files into memory, which may not be suitable for very large files. Consider implementing chunk-based reading for such cases.
- **File Permissions**: The new files may have different permissions compared to the originals. Adjustments might be necessary based on specific use cases.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
