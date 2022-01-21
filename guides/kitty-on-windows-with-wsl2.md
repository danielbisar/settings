# Using kitty on windows 11 with WSL2

Date: 2021-01-21
Windows Version: Windows 11 Pro 21H2 - OS build: 22000.438
WSL2: 
```
Windows Subsystem for Linux was last updated on 09.10.2021
WSL automatic updates are on.
Kernel version: 5.10.60.1
```
Graphics driver: NVIDIA 511.23

This guide expects a working WSL2 installation under windows with working
internet connectivity. This guide just provides a brief description what worked
for me. For more details see the referenced links.

Tested on a laptop and PC, both with an NVIDIA Graphics card.

1. Install latest mesa inside the WSL2 installation (tested with ubuntu 20.04)
   See: https://launchpad.net/~kisak/+archive/ubuntu/kisak-mesa

   ```
sudo add-apt-repository ppa:kisak/kisak-mesa
# sudo apt-get update    seems not to be necessary, at least it was automatically done on my installation
sudo apt upgrade     #  this should ask to install multiple mesa packages from kisak
   ```
2. optional: `sudo apt install x11-apps` and then run `xclock` worked for me even without vcxsrv
3. helpful but also not strictly necessary: `sudo apt install mesa-utils` and run `glxinfo -B`
   Your output should look something like:

   ```
name of display: :0
display: :0  screen: 0
direct rendering: Yes
Extended renderer info (GLX_MESA_query_renderer):
    Vendor: Microsoft Corporation (0xffffffff)
    Device: D3D12 (NVIDIA GeForce RTX 2060) (0xffffffff)
    Version: 21.3.4
    Accelerated: yes
    Video memory: 14120MB
    Unified memory: no
    Preferred profile: core (0x1)
    Max core profile version: 3.3
    Max compat profile version: 3.1
    Max GLES1 profile version: 1.1
    Max GLES[23] profile version: 3.0
OpenGL vendor string: Microsoft Corporation
OpenGL renderer string: D3D12 (NVIDIA GeForce RTX 2060)
OpenGL core profile version string: 3.3 (Core Profile) Mesa 21.3.4 - kisak-mesa PPA
OpenGL core profile shading language version string: 3.30
OpenGL core profile context flags: (none)
OpenGL core profile profile mask: core profile

OpenGL version string: 3.1 Mesa 21.3.4 - kisak-mesa PPA
OpenGL shading language version string: 1.40
OpenGL context flags: (none)

OpenGL ES profile version string: OpenGL ES 3.0 Mesa 21.3.4 - kisak-mesa PPA
OpenGL ES profile shading language version string: OpenGL ES GLSL ES 3.00
   ```

   Important part: For kitty to work you need OpenGL 3.SOMETHING 
   Didn't find the requirement right now.
4. Install kitty via `sudo apt install kitty`
5. start it via `kitty`
