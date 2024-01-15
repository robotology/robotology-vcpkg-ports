# robotology-vcpkg-ports
Collection of vcpkg ports used in the robotology organization.

## Usage

To use this repo, you will need to specify to `vcpkg` to use the ports contained in this repo using
the [`--overlay-ports` option](https://github.com/microsoft/vcpkg/blob/master/docs/specifications/ports-overlay.md). 

For example, you can first clone this repo:
~~~
git clone https://github.com/robotology/robotology-vcpkg-ports
~~~

Then, to install the `ipopt-binary` port, run `vcpkg` with the following options: 
~~~
./vcpkg.exe --overlay-ports=<repo_parent_directory>/robotology-vcpkg-ports install ipopt-binary:x64-windows
~~~

All the ports that end with `-binary` actually just download already available binaries, and install them in the vcpkg install prefix. 

## Available ports 

| Port name | Official vcpkg triplet for which it is available | 
|:---------:|:------------------------------------------------:|
| [`ensenso-binary`](ensenso-binary)| `x64-windows`                | 
| [`esdcan-binary`](esdcan-binary)| `x64-windows`                | 
| [`ipopt-binary`](ipopt-binary)| `x64-windows`                | 
| [`casadi`](casadi)| `x64-windows`                | 
| [`ycm-cmake-modules`](ycm-cmake-modules) | `x64-windows`                | 
| [`yarp`](yarp)| `x64-windows`                | 
| [`icub-firmware-shared`](icub-firmware-shared) | `x64-windows`                | 
| [`icub-main`](icub-main) | `x64-windows`                | 

