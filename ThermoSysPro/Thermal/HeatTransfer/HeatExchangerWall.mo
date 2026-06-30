within ThermoSysPro.Thermal.HeatTransfer;

model HeatExchangerWall "Heat exchanger wall"
  parameter Real ntubes = 1 "Number of pipes in parallel";
  parameter Units.SI.Length L = 1 "Tube length";
  parameter Units.SI.Diameter D = 0.2 "Internal tube diameter";
  parameter Units.SI.Thickness e = 2.e-3 "Wall thickness";
  parameter Units.SI.ThermalConductivity lambda = 26 "Wall thermal conductivity";
  parameter Integer Ns = 1 "Number of sections inside the wall";
  parameter Boolean dynamic_energy_balance = true "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Units.SI.SpecificHeatCapacity cpw = 1000 "Wall specific heat capacity (active if dynamic_energy_balance=true)" annotation(
    Evaluate = true,
    Dialog(enable = dynamic_energy_balance));
  parameter Units.SI.Density rhow = 7800 "Wall density (active if dynamic_energy_balance=true)" annotation(
    Evaluate = true,
    Dialog(enable = dynamic_energy_balance));
  parameter Boolean steady_state = true "true: start from steady state - false: start from T0 (active if dynamic_energy_balance=true)" annotation(
    Evaluate = true,
    Dialog(enable = dynamic_energy_balance));
  parameter Units.SI.Temperature T0 = 350 "Initial temperature (active if dynamic_energy_balance=true and steady_state=false)" annotation(
    Evaluate = true,
    Dialog(enable = dynamic_energy_balance and not steady_state));
  Units.SI.Power dW1[Ns](start = fill(3.e5, Ns), nominal = fill(3.e5, Ns)) "Power in section i of side 1";
  Units.SI.Power dW2[Ns](start = fill(3.e5, Ns), nominal = fill(3.e5, Ns)) "Power in section i of side 2";
  Units.SI.Temperature Tp1[Ns](start = fill(300, Ns)) "Wall temperature in section i of side 1";
  Units.SI.Temperature Tp2[Ns](start = fill(300, Ns)) "Wall temperature in section i of side 2";
  Units.SI.Temperature Tp[Ns](start = fill(300, Ns)) "Average wall temperature in section i";
  ThermoSysPro.Thermal.Connectors.ThermalPort WT2[Ns] "Side 2" annotation(
    Placement(transformation(extent = {{-10, 10}, {10, 30}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort WT1[Ns] "Side 1" annotation(
    Placement(transformation(extent = {{-10, -30}, {10, -10}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Units.SI.Length dx = L/Ns "Section length";
  parameter Units.SI.Mass dM = ntubes*rhow*pi*((D + 2*e)^2 - D^2)/4*dx "Wall section mass";
initial equation
  if dynamic_energy_balance then
    if steady_state then
      for i in 1:Ns loop
        der(Tp[i]) = 0;
      end for;
    else
      for i in 1:Ns loop
        Tp[i] = T0;
      end for;
    end if;
  end if;
equation
  WT1.T = Tp1;
  WT1.W = dW1;
  WT2.T = Tp2;
  WT2.W = dW2;
  for i in 1:Ns loop
/* Heat transfer on side 1 (internal) */
    dW1[i] = 2*pi*dx*ntubes*lambda*(Tp1[i] - Tp[i])/(Modelica.Math.log(1 + e/D));
/* Heat transfer on side 2 (external) */
    dW2[i] = 2*pi*dx*ntubes*lambda*(Tp2[i] - Tp[i])/(Modelica.Math.log(1 + e/(e + D)));
/* Thermal inertia */
    if dynamic_energy_balance then
      dM*cpw*der(Tp[i]) = dW2[i] + dW1[i];
    else
      0 = dW2[i] + dW1[i];
    end if;
  end for;
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 10}, {100, -10}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-80, 40}, {-20, 20}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "2"), Text(extent = {{-80, -20}, {-20, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "1"), Text(extent = {{20, 40}, {98, 20}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "External"), Text(extent = {{20, -20}, {98, -40}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "Internal")}),
    Diagram(graphics = {Rectangle(extent = {{-100, 10}, {100, -10}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid), Text(extent = {{-80, 30}, {-20, 10}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "Side 2"), Text(extent = {{-80, -10}, {-20, -30}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "Side 1"), Text(extent = {{20, -10}, {98, -30}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "Internal"), Text(extent = {{20, 30}, {98, 10}}, lineColor = {0, 0, 255}, fillColor = {255, 170, 170}, fillPattern = FillPattern.Solid, textString = "External")}),
    DymolaStoredErrors,
    Documentation(info = "
## Copyright © EDF 2002 - 2026   
## ThermoSysPro Version 4.2   
This component model is documented in Sect. 9.4.4 of the ThermoSysPro book.   
# Heat exchanger wall  

The wall separates the hot fluid circulating in the tube from the cold water out of the tube.  
Heat is exchanged between both fluids through the wall.  

The heat exchanger wall models the heat flow through a cylindric pipe wall under following assumptions:  
- The energy accumulation is considered in each mesh cell.  
- The heat flow through the wall is supposed to be positive when it is going from the outside to the inside of the pipe.  
- The phenomenon of longitudinal heat conduction in the wall is neglected.  
- The thermal conductivity of the wall is constant in space and time.  
The two latter hypotheses justify the 1D-modeling of the cylindric wall.  

## Modelica component model  

The equations mentioned below are implemented in the component *HeatExchangerWall*, located in the *Thermal.HeatTransfer* sub-library.  
This component has 2 connectors:  
- WT1: thermal port on internal side,  
- WT2: thermal port on external side.  


![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition | Modelica name |  
| :------------------------ | :----------------------------------------------------------------------------------------------------------------------- | :---------------------------------------- | :---------------------- | :--------------- |  
| \\\\(c\\_{p, w}\\\\)| Specific heat capacity of the wall| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\) || cpw |  
| \\\\(D\\\\)| Internal diameter of the pipes| \\\\(\\mathrm{m}\\\\)|| D |  
| \\\\(e\\\\)| Wall thickness| \\\\(\\mathrm{m}\\\\)|| e |  
| \\\\(L\\\\)| Pipe length| \\\\(\\mathrm{m}\\\\)|| L |  
| \\\\(N\\_{\\mathrm{S}}\\\\)| Number of sections inside the wall| \\\\(-\\\\)|| Ns |  
| \\\\(N\\_{\\mathrm{t}}\\\\)| Number of pipes in parallel| \\\\(-\\\\)|| ntubes |  
| \\\\(T\\_{\\mathrm{m}}\\\\)| Melting temperature of the tubes metal| \\\\(\\mathrm{K}\\\\)|| - |  
| \\\\(T\\_{\\mathrm{w}, i}\\\\)| Average wall temperature in section \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)||  Tp[i] |  
| \\\\(T\\_{\\mathrm{w} 1, i}\\\\)| Wall temperature in section \\\\(i\\\\) of side 1 \\(internal wall side\\)| \\\\(\\mathrm{K}\\\\)|| Tp1[i] |  
| \\\\(T\\_{\\mathrm{w} 2, i}\\\\)| Wall temperature in section \\\\(i\\\\) of side 2 \\(external wall side\\)| \\\\(\\mathrm{K}\\\\)|| Tp1[i] |  
| \\\\(\\Delta M\\_{\\mathrm{w}}\\\\) | Mass of a wall section| \\\\(\\mathrm{kg}\\\\)|| dM |  
| \\\\(\\Delta W\\_{l, i}\\\\)| Thermal power transferred by conduction from the center of the wall to the wall internal surface, for each section \\\\(i\\\\) | \\\\(\\mathrm{W}\\\\)|| dW1[i] |  
| \\\\(\\Delta W\\_{2, i}\\\\)| Thermal power transferred by conduction from the wall external surface to the center of the wall, for each section \\\\(i\\\\) | \\\\(\\mathrm{W}\\\\)|| dW2[i] |  
| \\\\(\\Delta x\\\\)| Wall section length| \\\\(\\mathrm{m}\\\\)| \\\\(L / N\\_{\\mathrm{S}}\\\\)| dx |  
| \\\\(\\lambda\\_{\\mathrm{w}}\\\\)| Wall thermal conductivity| \\\\(\\mathrm{W} / \\mathrm{m} / \\mathrm{K}\\\\)|| cpw |  
| \\\\(\\rho\\_{\\mathrm{w}}\\\\)| Wall density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rhow |  

## Governing equations  

The heat flux in the wall is computed using the formulation of Fourier’s  
equation expressed in cylindrical coordinates.  

### Dynamic energy balance equation for the wall  
    
- Validity domain:   
   
 \\\\(\\forall T\\_{\\mathrm{w}, i}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta M\\_{\\mathrm{w}} \\cdot c\\_{p, \\mathrm{w}} \\cdot \\frac{\\mathrm{d} T\\_{\\mathrm{w}, i}}{\\mathrm{d} t}=\\Delta W\\_{2, i}\\Delta W\\_{l, i}$$  

- Comments:   
   
 \\\\(\\Delta M\\_{\\mathrm{w}}\\\\) is given by \\\\(\\Delta M\\_{\\mathrm{W}}=N\\_{\\mathrm{t}} \\cdot \\rho\\_{\\mathrm{W}} \\cdot \\pi \\cdot \\frac{\\(D+2 \\cdot e\\)^{2}D^{2}}{4} \\cdot \\Delta x\\\\)   

### Fourier’s equation in cylindrical coordinates \\(conduction through the internal side of the wall\\)  
    
- Validity domain:   
   
\\\\(\\forall T\\_{\\mathrm{w}, i}\\\\) and \\\\(\\forall T\\_{\\mathrm{w} 1, i}\\\\)  

- Mathematical formulation:   
   
 $$\\Delta W\\_{l, i}=N\\_{\\mathrm{t}} \\cdot \\lambda\\_{\\mathrm{w}} \\cdot \\frac{2 \\cdot \\pi \\cdot \\Delta x}{\\ln \\(\\(e+D\\) / D\\)} \\cdot\\left\\(T\\_{\\mathrm{w}, i}T\\_{\\mathrm{w} 1, i}\\right\\)$$  

- Comments:   
   
   

### Fourier’s equation in cylindrical coordinates \\(conduction through the external side of the wall\\)  
    
- Validity domain:   
   
\\\\(\\forall T\\_{\\mathrm{w}, i}\\\\) and \\\\(\\forall T\\_{\\mathrm{w} 2, i}\\\\)  

- Mathematical formulation:   
   
$$\\Delta W\\_{2, i}=N\\_{\\mathrm{t}} \\cdot \\lambda\\_{\\mathrm{w}} \\cdot \\frac{2 \\cdot \\pi \\cdot \\Delta x}{\\ln \\(\\(2 \\cdot e+D\\) /\\(e+D\\)\\)} \\cdot\\left\\(T\\_{\\mathrm{w} 2, i}T\\_{\\mathrm{w}, i}\\right\\)$$   

- Comments:   

## References  

El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 9.4.4. Springer Nature Switzerland AG.  
    ", revisions = "
Author  

Guillaume Larrignon   

    "));
end HeatExchangerWall;