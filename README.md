# Cluster Compiler - Official Releases

This repository is the official release version of the Cluster compiler (`cluster-v0.1`). Here you will find compiled standalone binaries for the compiler.

## How to Install & Use the Compiler

### 1. Download the Executable
Go to the **Releases** page of this repository and download the latest compiled `cluster-v0.1` binary for your platform.

### 2. Make it Executable
If you are on Linux or macOS, grant execute permissions to the downloaded binary:
```bash
chmod +x cluster-v0.1
```

### 3. Move to System Path (Optional)
To run the compiler from anywhere in your terminal, move it to your system path:
```bash
sudo mv cluster-v0.1 /usr/local/bin/
```

### 4. Running a Cluster Source File
You can compile and execute `.cl` (or `.zk`) Cluster source files directly:
```bash
cluster-v0.1 main.cl
```

### 5. Standard Compiler Operations
- **Initialize a New Project**:
  ```bash
  cluster-v0.1 init <project_name>
  ```
- **Initialize a Robotics Template**:
  ```bash
  cluster-v0.1 init --rpi <project_name>
  ```
- **Compile to Binary Without Running**:
  ```bash
  cluster-v0.1 build main.cl
  ```
- **Auto-Format a Source File**:
  ```bash
  cluster-v0.1 fmt main.cl
  ```
- **Enable Release Optimization (`-O3`)**:
  ```bash
  cluster-v0.1 main.cl --release
  ```

## License
Refer to the `LICENSE` file in this repository. All rights reserved.