within ThermoSysPro.Solar.Collectors;

model FresnelField "Fresnel field"
  parameter Units.SI.Area A = 10e4 "Aperture area of a train";
  parameter Integer mode_efficency = 1 "1:Definition of each parameter : rho, a, tau , geo. 2:Definition of the global optical efficency";
  parameter Real eta0 = 0.625 "Global optical efficency at normal irradiation";
  parameter Real rho = 0.935 "Reflexivity of the primary reflector";
  parameter Real a = 0.955 "Absorptivity of the collector";
  parameter Real tau = 0.965 "Transmissivity of the glass envelope";
  parameter Real geo = 0.725 "Geometric default factor";
  parameter Real dispo = 1 "Mean disponibility of the field";
  parameter Real clean = 1 "Mean cleanliness factor";
  parameter Units.SI.Length h = 7.4 "Height of a collector";
  parameter ThermoSysPro.Units.SI.Length Lc = 44.8 "Length of a collector";
  parameter Units.SI.Length w = 11.46 "Aperture width of a collector";
  parameter Units.SI.CoefficientOfHeatTransfer hc = 1 "Heat transfer coefficient";
  parameter Boolean thermalLossPhy = true "true: thermal loss using a physical equation - false: thermal loss using a polynomial equation f(deltaT)";
  parameter Units.SI.Diameter D = 0.07 "External tube diameter (active if thermalLossPhy=true)";
  parameter Real F12 = 1 "View factor to surroundings radiation heat loss (active if thermalLossPhy=true)";
  parameter Real Emi = 0.8 "Tube emissivity (active if thermalLossPhy=true)";
  parameter Real A1 = 0.1598 "x coefficient of the linear thermal loss caracteristics Qloss=f(deltaT) (active if thermalLossPhy=false)";
  parameter Real A2 = 0.0057 "x^2 coefficient of the linear thermal loss caracteristics Qloss=f(deltaT) (active if thermalLossPhy=false)";
  parameter Real B0 = 0.995 "Constant coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B1 = -4e-4 "x coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B2 = -3e-5 "x^2 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B3 = 1e-6 "x^3 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B4 = -5e-8 "x^4 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B5 = 3e-10 "x^5 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Real B6 = 0 "x^6 coefficient of the KT caracteristics KT=f(thetaT)";
  parameter Units.SI.Temperature T0 = 300 "Atmospheric temperature";
  parameter Integer Ns = 10 "Number of cells (sections) in the field";
  parameter ThermoSysPro.Units.nonSI.Angle_deg SunA0 = 90 "Sun azimuth angle by default";
  parameter ThermoSysPro.Units.nonSI.Angle_deg SunG0 = 1e-6 "Sun elevation angle by default";
  parameter Units.SI.Irradiance SunDNI0 = 1000 "Direct normal irradiance by default";
  parameter Real trackingFactor = 1 "Mean sun tracking system factor";
  Units.SI.Length L(start = 44.8) "Length of a train";
  Units.SI.Power dPth[Ns](start = fill(80e7/Ns, Ns)) "Thermal Power transfered to the fluid for each section";
  Real ETA0(start = 0.625) "Definition of efficency at normal irradiation";
  Real sin_alphaS(start = 1) "Used in the definition of thetaL and thetaT";
  ThermoSysPro.Units.nonSI.Angle_deg thetaT(start = 0) "Transversal incidence angle";
  ThermoSysPro.Units.nonSI.Angle_deg thetaL(start = 0) "Longitudinal incidence angle";
  Real track "Mean sun tracking system factor";
  Units.SI.Power Pth(start = 563e6) "Thermal Power transfered to the the fluid";
  Units.SI.Power Qrec(start = 625e6) "Thermal Power received by the receptor";
  Units.SI.Power Qloss(start = 625e5) "Thermal loss on the receptor";
  Real KT(start = 1) "Transversal incidence modifier fonction";
  Real KL(start = 1) "Longitudinal incidence modifier fonction";
  ThermoSysPro.Units.SI.TemperatureDifference deltaT[Ns](start = fill(50, Ns)) "Mean tempertaure difference";
  ThermoSysPro.Units.nonSI.Angle_deg gammaS(start = 90) "Sun azimuth angle";
  ThermoSysPro.Units.nonSI.Angle_deg alphaS(start = 1e-6) "Sun elevation angle";
  Units.SI.Irradiance DNI(start = 2000) "Direct normal irradiance";
  Units.SI.Temperature T[Ns](start = fill(300, Ns)) "Pipe wall Temperature ";
  Units.SI.Power dQloss[Ns](start = fill(563e6/Ns, Ns)) "Thermal loss on the receptor by each cell (section)";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunG "Azimuthal angle of the sun as function of time" annotation(
    Placement(transformation(origin = {68, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunDNI "Direct Normal Irradiance as fnction of time" annotation(
    Placement(transformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 180)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal SunA "Elevation angle of the sun as function of time" annotation(
    Placement(transformation(origin = {92, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
  ThermoSysPro.Thermal.Connectors.ThermalPort P[Ns] "Thermal Power transfered to the fluid" annotation(
    Placement(transformation(extent = {{-10, -70}, {10, -50}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Track "Track" annotation(
    Placement(transformation(origin = {-90, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 270)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  parameter Real eps = 1e-6 "epsilon";
equation
/* Input connectors */
  alphaS = SunA.signal;
  gammaS = SunG.signal;
  DNI = SunDNI.signal;
  track = Track.signal;
  if (cardinality(SunA) == 0) then
    SunA.signal = SunA0;
  end if;
  if (cardinality(SunG) == 0) then
    SunG.signal = SunG0;
  end if;
  if (cardinality(SunDNI) == 0) then
    SunDNI.signal = SunDNI0;
  end if;
  if (cardinality(Track) == 0) then
    Track.signal = trackingFactor;
  end if;
/* Output connectors */
  P.W = -dPth;
  P.T = T;
/* Power conservation + Thermal loss on the receptor */
  for i in 1:Ns loop
/* Power conservation + Thermal loss on the receptor */
    deltaT[i] = T[i] - T0;
    dQloss[i] = if thermalLossPhy then pi*D*L/Ns*(0.5*F12*Emi*5.67e-8*(T[i]^4 - (0.0552*T0^(1.5))^4) + hc*(T[i] - T0)) else L/Ns*(A1*deltaT[i] + A2*deltaT[i]^2);
    dPth[i] = Qrec/Ns - dQloss[i];
  end for;
  Pth = sum(dPth);
  Qloss = Qrec - Pth;
/* Definition of thetaT and thetaL */
  sin_alphaS = abs(sin(pi*alphaS/180));
  thetaT = if noEvent(sin_alphaS <= eps) then 90 else 180*atan(sin(pi*gammaS/180)/tan(pi*alphaS/180))/pi;
  thetaL = 180*acos(sqrt(1 - (cos(pi*alphaS/180)*cos(pi*gammaS/180))^2))/pi;
/* Optical efficency at normal irradiation */
  if (mode_efficency == 1) then
    ETA0 = rho*a*tau*geo;
  else
    ETA0 = eta0;
  end if;
/* Definition of KT */
  KT = B6*abs(thetaT)^6 + B5*abs(thetaT)^5 + B4*abs(thetaT)^4 + B3*abs(thetaT)^3 + B2*abs(thetaT)^2 + B1*abs(thetaT) + B0;
/* Definition of KL */
  KL = cos(pi*thetaL/180)*(1 - h*tan(pi*thetaL/180)/Lc);
/* Thermal Power received by the receptor */
  Qrec = A*DNI*ETA0*KT*KL*dispo*track*clean;
/* Length of the pipe and pipe section */
  L = A/w;
  annotation(
    Icon(graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{100, 22}, {60, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-84, -10}, {-80, -60}}, lineColor = {255, 255, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{80, 56}, {-80, -24}, {-16, -56}}, color = {255, 255, 0}), Line(points = {{80, 52}, {-80, -28}, {-24, -56}}, color = {255, 255, 0}), Line(points = {{80, 48}, {-80, -32}, {-32, -56}}, color = {255, 255, 0}), Line(points = {{80, 44}, {-80, -36}, {-40, -56}}, color = {255, 255, 0}), Line(points = {{80, 40}, {-80, -40}, {-48, -56}}, color = {255, 255, 0}), Line(points = {{80, 36}, {-80, -44}, {-56, -56}}, color = {255, 255, 0}), Line(points = {{80, 32}, {-80, -48}, {-64, -56}}, color = {255, 255, 0}), Ellipse(extent = {{22, -28}, {86, -40}}, lineColor = {0, 0, 255}), Rectangle(extent = {{-74, -56}, {0, -60}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid)}),
    Diagram(graphics = {Rectangle(extent = {{-100, 60}, {100, -60}}, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Ellipse(extent = {{100, 22}, {60, 60}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-84, -10}, {-80, -60}}, lineColor = {255, 255, 0}, fillColor = {0, 0, 0}, fillPattern = FillPattern.Solid), Line(points = {{80, 56}, {-80, -24}, {-16, -56}}, color = {255, 255, 0}), Line(points = {{80, 52}, {-80, -28}, {-24, -56}}, color = {255, 255, 0}), Line(points = {{80, 48}, {-80, -32}, {-32, -56}}, color = {255, 255, 0}), Line(points = {{80, 44}, {-80, -36}, {-40, -56}}, color = {255, 255, 0}), Line(points = {{80, 40}, {-80, -40}, {-48, -56}}, color = {255, 255, 0}), Line(points = {{80, 36}, {-80, -44}, {-56, -56}}, color = {255, 255, 0}), Line(points = {{80, 32}, {-80, -48}, {-64, -56}}, color = {255, 255, 0}), Ellipse(extent = {{22, -28}, {86, -40}}, lineColor = {0, 0, 255}), Rectangle(extent = {{-74, -56}, {0, -60}}, lineColor = {0, 0, 0}, fillColor = {255, 0, 0}, fillPattern = FillPattern.Solid)}),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 16.2 of the ThermoSysPro book.   
# Fresnel field   
   
The Linear Fresnel Reflector (LFR) is similar to the [parabolic trough collector](modelica://ThermoSysPro.Solar.Collectors.SolarCollector).  
However, its receiver is not moving and thus made up of fewer moving parts.  
This eliminates the need for strengthening materials.  

The LFR concentrates the solar radiation through long parallel rows of flat mirrors.  
These modular mirrors focus the sunlight onto the receiver, which consists of a system of tubes through which the working fluid is pumped.  
In addition, another mirror is placed above the absorber tube to reduce optical losses.  
Flat mirrors allow more reflective surface in the same amount of space than a parabolic reflector, and they are much cheaper than parabolic reflectors.  



## Modelica component model  

The equations mentioned below are implemented in the component *FresnelField*, located in the *Solar.Collectors* sub-library.   
This component has 5 connectors:  
- Track: track input,  
- SunG: azimuthal angle of the sun as function of time,  
- SanA: elevation angle of the sun as function of time,  
- SunDNI: solar radiation (Direct Normal Irradiance) as function of time,  
- P: thermal power transfered to the fluid.   
   
![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Solar.Collectors.FresnelField.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Solar.Collectors.FresnelField.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :-------------------- | :------------------------------------------------------------------------ | :------------------------------------------- | :-------------------------------- | :-------------------------------- |  
| \\\\(a\\\\)| Absorptivity of a train | \\\\(-\\\\)| 0.955| a |  
| \\\\(A\\\\)| Area of all collectors| \\\\(\\mathrm{m}^{2}\\\\)| | A |  
| \\\\(D\\\\)| External pipe diameter \\(absorber\\)| \\\\(\\mathrm{m}\\\\)| |D |  
| \\\\(F\\_{12}\\\\)| View factor to surroundings \\(radiation heat loss\\)| \\\\(-\\\\)| |F12 |  
| \\\\(h\\_{\\mathrm{c}}\\\\)| Convective heat transfer coefficient between the ambient air and the pipe | \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) | | hc |  
| \\\\(K\\_{\\mathrm{L}}\\\\)| Longitudinal incidence angle modifier| \\\\(-\\\\)| | KL |  
| \\\\(K\\_{\\mathrm{T}}\\\\)| Transversal incidence angle modifier| \\\\(-\\\\)| | KT |  
| \\\\(L\\\\)| Length of a train | \\\\(\\mathrm{m}\\\\) | \\\\(\\frac{A}{w}\\\\)| L |  
| \\\\(Lc\\\\)| Length of the collector| \\\\(\\mathrm{m}\\\\) | \\\\(-\\\\)| Lc |  
| \\\\(N\\\\)| Number of cells \\(sections\\) in the solar field| \\\\(-\\\\)| | Ns |  
| \\\\(T\\_{\\text {atm }}\\\\)| Atmospheric temperature| \\\\(\\mathrm{K}\\\\) | | T0 |  
| \\\\(T\\_{\\mathrm{sky}}\\\\)| Sky temperature| \\\\(\\mathrm{K}\\\\) | \\\\(0.0552 \\cdot T\\_{\\text {atm }}^{1.5}\\\\) | 0.0552*T0^1.5 |  
| \\\\(T\\_{\\mathrm{w}, i}\\\\)| Temperature of the outer receiver surface for cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\) | | T[i] |  
| \\\\(w\\\\)| Aperture width of the collector| \\\\(\\mathrm{m}\\\\) | | w |  
| \\\\(W\\_{\\text {abs }}\\\\)| Solar radiation absorbed by the receiver| \\\\(\\mathrm{W}\\\\) | | Qrec |  
| \\\\(W\\_{\\mathrm{conv}, i}\\\\)| Convection power loss from the outer pipe surface to the ambient for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) |  | |  
| \\\\(W\\_{\\mathrm{rad}, i}\\\\)| Radiation power losses from the outer pipe surface to the ambient for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | |  
| \\\\(W\\_{\\mathrm{t}, i}\\\\)| Thermal power transferred to the fluid for each cell \\(section\\) for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | dPth[i] |  
| \\\\(z\\\\)| Height of the collector| \\\\(\\mathrm{m}\\\\) | | h |  
| \\\\(\\alpha\\_{\\mathrm{s}}\\\\)| Sun elevation angle \\(angle between the straight line to the sun and the horizontal plane\\)| \\\\(^{\\circ}\\\\)| | SunG0 |  
| \\\\(\\gamma\\_{\\mathrm{s}}\\\\)| Sun azimuth angle \\(angle between the North and the solar position projected on the horizontal plane\\) | \\\\(^{\\circ}\\\\)| | SunA0 |  
| \\\\(\\varepsilon\\_{\\mathrm{t}}\\\\) | Tube emissivity| \\\\(-\\\\)| | emi |  
| \\\\(\\eta\\_{\\mathrm{av}}\\\\)| Mean availability of the solar field| \\\\(-\\\\)| \\\\(\\le 1 \\\\)| dispo |  
| \\\\(\\eta\\_{\\mathrm{cl}}\\\\)| Mean cleanliness factor| \\\\(-\\\\) | \\\\( \\le 1 \\\\) | clean |  
|\\\\(\\eta\\_{\\text {opt }}\\\\) | Optical efficiency at normal irradiation | \\\\(-\\\\) | | eta0 |  
|\\\\(a\\\\) | Mean sun tracking system factor | \\\\(-\\\\) | \\\\(\\leq 1\\\\) | track |  
|\\\\(\\theta\\_{\\mathrm{L}}\\\\) | Longitudinal incidence angle (angle between the zenith and the projection of the straight line to the sun onto the longitudinal plane \"North-South\") | \\\\(^{\\circ}\\\\) | | thetaL|  
|\\\\(\\theta\\_{\\mathrm{T}}\\\\) | Transverse incidence angle (angle between the zenith and the projection of the straight line to the sun onto the transverse plane \"North-South\") | \\\\(^\\circ\\\\) | | thetaT |  
|\\\\(\\rho\\\\) | Reflexivity of the primary reflector | \\\\(-\\\\) | \\\\(\\approx 0.935\\\\) | rho |  
|\\\\(\\sigma\\\\) | Stefan-Boltzmann constant | \\\\(\\mathrm{W} /\\left\\(\\mathrm{m}^{2} \\mathrm{K}^{4}\\right\\)\\\\) | \\\\(5.67 \\times 10^{-8}\\\\) | 5.67e-8 |  
|\\\\(\\tau\\\\) | Transmissivity of the pipe wall | \\\\(-\\\\) | \\\\(\\approx 0.965\\\\) | tau |  
|\\\\(\\phi\\_{\\text {sun }}\\\\) | Solar radiation (direct normal irradiance - DNI)| \\\\(\\mathrm{W} / \\mathrm{m}^{2}\\\\) | | DNI |  
|\\\\(\\chi\\\\) | Geometric default factor | \\\\(-\\\\) | | geo |  

## Governing equations  

### Thermal power received by the receiver  

- Mathematical formulation:   

$$W\\_{\\mathrm{rec}}=A \\cdot \\phi\\_{\\mathrm{sun}} \\cdot \\eta\\_{\\mathrm{opt}} \\cdot K\\_{\\mathrm{T}} \\cdot K\\_{\\mathrm{L}} \\cdot \\eta\\_{\\mathrm{av}} \\cdot \\eta\\_{\\mathrm{tr}} \\cdot \\eta\\_{\\mathrm{c} 1}$$  

- Comments:  

The optical efficiency at normal irradiation is given by  
\\\\(\\eta\\_{\\mathrm{opt}}=\\rho \\cdot a \\cdot \\tau \\cdot \\chi\\\\).  
It is also possible for the user to directly provide a value for  
\\\\(\\eta\\_{\\mathrm{opt}}\\\\). <br/>  
The polynomial function \\\\(K_T\\\\) is obtained by polynomial interpolation  
based on the values obtained from Novatec Solar.  
The transverse incidence angle  
modifier is given by:  
$$   K_{\\mathrm{T}}= 3 \\times 10^{-10} \\cdot\\left|\\theta_{\\mathrm{T}}\\right|^{5}-5 \\times 10^{-8} \\cdot\\left|\\theta_{\\mathrm{T}}\\right|^{4}+1 \\times 10^{-6} \\cdot\\left|\\theta_{\\mathrm{T}}\\right|^{3} \\\\   -3 \\times 10^{-5} \\cdot\\left|\\theta_{\\mathrm{T}}\\right|^{2}-4 \\times 10^{-4} \\cdot\\left|\\theta_{\\mathrm{T}}\\right|+0.995$$  
The longitudinal incidence angle modifier is given by  
\\\\(K\\_{\\mathrm{L}}=\\cos \\left\\(\\theta\\_{\\mathrm{L}}\\right\\) \\cdot\\left\\(1-\\frac{z}{\\mathrm{L}} \\cdot \\tan \\left\\(\\theta\\_{\\mathrm{L}}\\right\\)\\right\\)\\\\).<br/>  
The longitudinal incidence angle is given by \\\\(\\theta\\_{\\mathrm{L}}=a \\cdot \\cos \\(\\sqrt{\\left\\(1-\\cos ^{2}\\left\\(\\alpha\\_{\\mathrm{s}}\\right\\) \\cdot \\cos ^{2}\\left\\(\\gamma\\_{\\mathrm{s}}\\right\\)\\right.}\\)\\\\).<br/>  
The transverse incidence angle is given by  
$$   \\theta_{\\mathrm{T}}=\\left\\{\\begin{array}{ll}90  \\text{ for } \\left|\\sin \\left(\\alpha_{\\mathrm{s}})| \\leq 10^{-6}\\right.\\right. \\\\ \\arctan \\left(\\frac{\\sin (\\gamma_{\\mathrm{s}})}{\\tan (\\alpha_{\\mathrm{s}})}\\right)  \\text{ for }\\left|\\sin \\left(\\alpha_{s}) |>10^{-6}\\right.\\right.\\end{array}\\right.$$  

### Energy balance equation for each cell (power transferred to the fluid)  

- Mathematical formulation:   
   
 $$W\\_{\\mathrm{t}, i}=\\frac{W\\_{\\mathrm{abs}}}{N}-W\\_{\\mathrm{rad}, i}-W\\_{\\mathrm{conv}, i}$$  

- Comments:   
   
The net power received by each tube segment is equal to the total power absorbed by the receiver for that segment minus the losses by radiation to the sky and convection to the ambient for that segment   


### Radiation power losses  

- Mathematical formulation:   
   
$$W\\_{\\mathrm{rad} \\mathrm{t}}=0.5 \\cdot F\\_{12} \\cdot \\sigma \\cdot A\\_{\\mathrm{t}, i} \\cdot \\varepsilon\\_{\\mathrm{t}} \\cdot\\left\\(T\\_{\\mathrm{w}, i}^{4}-T\\_{\\mathrm{sky}}^{4}\\right\\)$$  


### Convection power losses to the ambient  


    

- Mathematical formulation:   
   
$$W\\_{\\text {conv }, i}=A\\_{\\mathrm{t}, i} \\cdot h\\_{\\mathrm{c}} \\cdot\\left\\(T\\_{\\mathrm{w}, i}-T\\_{\\mathrm{atm}}\\right\\)$$  

- Comments:   
   
\\\\(h\\_{\\mathrm{c}}\\\\) is given as input by the user.  

## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 16.2. Springer Nature Switzerland AG.  
    ", revisions = "
    "));
end FresnelField;