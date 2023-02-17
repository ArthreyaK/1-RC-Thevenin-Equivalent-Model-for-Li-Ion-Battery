# 1-RC Thevenin Equivalent Model for Li-Ion Battery
## _Objective_
The project aims to load the data set of test current and test voltage observed experimentally with the time stamps and find an equivalent circuit that models the characteristics of the cell. Studying the Thevenin Equivalent Circuit of a Li-ion Battery is a classic example of how RC Equivalent Circuits can be used in any electrical model. The project focuses on designing and creating a MATLAB simulation of the Li-ion Battery using Coulomb Counting Method.

## _Experiment and Data Collection Procedures_
The data set for the purpose of implementation is drawn from a capstone project. The process of actual extracation is quite cumbersome. The process uses the Coulomb Counting Method of State of Charge (SOC) estimation. The whole process can be segment into sub-process and scripts.

### _Open Circuit Voltage Test_
**Script 1** </br>
We charge the cell to 100 % SOC by the process as prescribed by the manufacturer. Then we will make the ambient and surface temperature of the cell to a certain temperature, say T &deg;C. Then we will discharge the cell at C/30 rate (very slow) until we reach V<sub>min</sub>.</br>
**Script 2** </br>
Then we will make the ambient and surface temperature of the cell to room temperature, i.e. 25 &deg;C. There after we will charge/discharge to reach 0 % SOC at C/30 rate.</br>
**Script 3** </br>
We will make the ambient and surface temperature of the cell to a certain temperature, say T &deg;C. We charge the cell to V<sub>max</sub> at C/30 rate to avoid ohmic drop effects.</br>
**Script 4** </br>
Then we will make the ambient and surface temperature of the cell to room temperature, i.e. 25 &deg;C. There after we will charge/discharge to reach 0 % SOC at C/30 rate.

### _Coulombic Efficiency_
Coulombic efficiency is one of the parameter which explicitly depend on temperature.
We could find out the Coulombic Efficiency ($\eta$) using the relation:
<p style="text-align: center;">$\eta$ (T &deg;C) = $\frac{Total Ah charge discharged}{Total Ah charge charged}$</p>
In similar fashion Coulombic Efficiency is calcualted for different temperatures.

### _State of Charge Estimation_
State of charge (SOC) is the level of charge of an electric battery relative to its capacity. The units of SOC are percentage points (0% = empty; 100% = full). This process is known as coulomb count method.
<p style="text-align: center;"> z[k] = 1- ($\eta$ [k] x i [k] / Q)</p>

## _Voltage Observation_
We have experimentally observed voltage of cell with respect to time. The senesor frequency is 1 Hz.

