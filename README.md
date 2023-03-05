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
We have experimentally observed voltage of cell with respect to time. The senesor frequency is 1 Hz. The voltage sensors are basically ADC (Analog to Digital Convertor). If the voltage range is very high, to make the reading more accurate we also use chipsets.
</br>
The voltage reading is done with the consideration of cell temperature and SOC conditions. It is basically, compared and cleaned with the data set collected for different temperature and at different SOC condition.
</br>
_The above mentioned data set collection is taken from the capstone project of Introductory Course on Battery Mangement offered by Proff. George Prett._

## _Need for Equivalent Circuit_
An equivalent circuit is a simplified representation of an electrical system that captures the behavior of the system. Equivalent circuits are used to analyze the performance of electrical systems. In the case of battery management systems, the equivalent circuit is used to represent the behavior of the battery, such as its capacity, voltage, current, and resistance. The equivalent circuit is then used to predict the behavior of the battery in different conditions. In addition, the equivalent circuit can be used to determine the optimal charging and discharging parameters for the battery. Thus it will help to ensure that the battery is not overcharged or over-discharged, which can lead to reduced battery life.

## _1-RC Thevenin Equivalent Model_
Thevenin equivalent circuits are among the most commonly used equivalent circuits in the electrical domain. This type of equivalent circuit is used to represent the battery's voltage, current, and resistance. The circuit consists of a voltage source, resistance, and two nodes. The two nodes are the positive and negative terminals of the battery, where the voltage source is the battery's voltage, and the resistance is its internal resistance. This circuit is slightly modified with a capacitor. The capacitor represents the battery's capacity, which is the amount of energy the battery can store. This circuit is used to model the behavior of the battery in different conditions.
</br>
![alt text]([http://url/to/img.png](https://www.researchgate.net/publication/340115101/figure/fig1/AS:872454356467712@1585020736438/1RC-Equivalent-circuit-model.ppm))





