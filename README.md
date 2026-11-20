# Finite-Element-Analysis-of-Carbon-Carbon-Composite-Tensile-Behaviour
Finite Element Analysis of Carbon-Carbon Composite Tensile Behaviour Using Experimental Data
Background
This project was developed as a computational extension of my MSc thesis on the mechanical feasibility of carbon-carbon composites.

The original thesis involved tensile, hot-tensile, flexural, shear and wear characterization of carbon-carbon composite materials.

Objective
To develop a finite element model in MATLAB and compare numerical predictions with experimental tensile-test results.

Experimental Reference
Experimental tensile strength: approximately 91 MPa

The loading conditions were based on tensile testing performed during MSc research.

Method
The model was developed using:

One-dimensional finite element method
Direct stiffness method
Mesh discretization
Global stiffness matrix assembly
Boundary condition implementation
Stress and displacement calculations
Results
The FEM model predicted a stress value of approximately 90.65 MPa under tensile loading.

This result showed good agreement with the experimentally measured tensile strength obtained during the thesis study.

Outputs generated:

Displacement distribution
Stress distribution
Software
MATLAB Online
...
Outputs generated:

Displacement distribution
Stress distribution

Software
MATLAB Online

Author
Hanisha Thanikatchalam

## Mesh Convergence Study

To evaluate the reliability of the finite element model, a mesh convergence study was carried out using 2, 4, 8, 16 and 32 elements.

The stress and displacement predictions showed negligible changes with increasing mesh density, indicating that the numerical solution is stable and largely independent of the selected mesh size.

This verification step provides additional confidence in the FEM results obtained for the carbon-carbon composite tensile specimen.

Additional output:
mesh_convergence.png

Author
Hanisha Thanikatchalam
