within ThermoSysPro.Solar.Collectors;

model SolarCollector "Solar Collector"
  parameter Units.SI.Length f = 1 "Focal length";
  parameter Real RimAngle = 70 "Rim Angle";
  parameter Units.SI.Length L = 1 "Absorber pipe length or collector length";
  parameter Integer Ns = 10 "Number of cells";
  parameter Units.SI.Diameter DTube = 0.1 "Tube diameter";
  parameter Units.SI.Diameter DGlass = 0.11 "Glass diameter";
  parameter Units.SI.Length e = 1.e-4 "Glass thickness";
  parameter Real F12 = 1 "View factor to surroundings,radiation heat loss";
  parameter Real TauN = 0.91 "Glass transmittivity at normal incidence";
  parameter Real AlphaN = 0.97 "Tube absorptivity at normal incidence";
  parameter Real AlphaGlass = 0.03 "Glass absorptivity at normal incidence";
  parameter Real EpsTube = 0.06 "Tube emissivity";
  parameter Real EpsGlass = 0.86 "Glass emissivity";
  parameter Real R = 0.8 "Mirror reflectivity";
  parameter Real Gamma = 0.83 "Intercept factor";
  parameter Units.SI.ThermalConductivity Lambda = 0.00262 "Gas thermal conductivity";
  parameter Units.SI.CoefficientOfHeatTransfer h = 3.06 "Heat transfer coefficient";
  parameter Units.SI.SpecificHeatCapacity cp_glass = 720 "Glass heat capacity";
  parameter Units.SI.Density rho_glass = 2500 "Glass density";
  parameter Units.SI.Temperature T0 = 350 "Initial temperature (active if steady_state=false)";
  parameter Boolean steady_state = true "true: start from steady state - false: start from T0";
  Real PhiSun(start = 1) "Radiation flux";
  Real Theta(start = 0) "Incidence angle";
  Units.SI.Temperature Twall[Ns](start = fill(350, Ns)) "Pipe wall temperature";
  Units.SI.Temperature Tatm(start = 300) "Atmospheric temperature";
  Real WTube[Ns](start = fill(1, Ns)) "Flux to the pipe";
  Units.SI.Area AReflector(start = 1) "Reflector surface";
  Units.SI.Area AGlass(start = 1) "Glass surface";
  Units.SI.Area ATube(start = 1) "Pipe surface";
  Units.SI.Mass dM(start = 1) "Glass mass";
  Real OptEff(start = 1) "Optical efficiency";
  Real IAM(start = 1) "Incidence angle modifier";
  Real TauAlphaN(start = 1) "Transmittivity-absorptivity factor";
  Units.SI.Power WRadWall[Ns](start = fill(0, Ns)) "Radiation of the wall";
  Units.SI.Power WConvWall[Ns](start = fill(0, Ns)) "Convection of the wall";
  Units.SI.Power WCondWall[Ns](start = fill(0, Ns)) "Conduction of the wall";
  Units.SI.Power WRadGlass[Ns](start = fill(0, Ns)) "Radiation of the glass layer";
  Units.SI.Power WConvGlass[Ns](start = fill(0, Ns)) "Convection of the glass layer";
  Units.SI.Power WAbsGlass[Ns](start = fill(0, Ns)) "Absorption of the glass layer";
  Units.SI.Temperature Tsky(start = 300) "Sky temperature";
  Units.SI.Temperature Tglass[Ns](start = fill(300, Ns)) "Glass temperature";
  //ThermoSysPro.Units.SI.Power WW ;
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ISun "Flux (W/m²)" annotation(
    Placement(transformation(extent = {{-250, 100}, {-230, 120}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IncidenceAngle "Degré" annotation(
    Placement(transformation(extent = {{-250, 50}, {-230, 70}}, rotation = 0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal AtmTemp "Atmospheric temperature (K)" annotation(
    Placement(transformation(extent = {{-250, 150}, {-230, 170}}, rotation = 0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort ITemperature[Ns] annotation(
    Placement(transformation(extent = {{-63, -63}, {-43, -43}}, rotation = 0)));
protected
  constant Real pi = Modelica.Constants.pi "pi";
  constant Real sigma = 5.67e-8 "Bolzmann constant";
initial equation
  if steady_state then
    for i in 1:Ns loop
      der(Tglass[i]) = 0;
    end for;
  else
    for i in 1:Ns loop
      Tglass[i] = T0;
    end for;
  end if;
equation
/* Input connectors */
  PhiSun = ISun.signal;
  Theta = IncidenceAngle.signal;
  Tatm = AtmTemp.signal;
/* Reflector area */
  AReflector = f*4*Modelica.Math.tan(RimAngle*pi/180./2)*L;
/* Glass area */
  AGlass = pi*DGlass*L;
/* Glass mass of one section */
  dM = rho_glass*pi*((DGlass + 2*e)^2 - DGlass^2)/4*L/Ns;
/* Pipe area */
  ATube = pi*DTube*L;
/* Incidence angle modifier model */
  IAM = Modelica.Math.cos(Theta*pi/180);
/* Transmittivity-absorptivity factor */
  TauAlphaN = TauN*AlphaN*1/(1 - (1 - TauN)*(AlphaN));
/* Optical efficiency */
  OptEff = IAM*TauAlphaN*Gamma*R;
/* Sky temperature */
  Tsky = 0.0552*Tatm^(1.5);
  for i in 1:Ns loop
/* Input connectors */
    Twall[i] = ITemperature[i].T;
/* Output connectors */
    ITemperature[i].W = WTube[i];
/* Wall */
    WRadWall[i] = ATube/Ns*sigma*EpsTube*(Twall[i]^(4) - Tglass[i]^(4));
    WConvWall[i] = 0;
    WCondWall[i] = ATube/Ns*Lambda*(Twall[i] - Tglass[i])/(DTube/2*Modelica.Math.log(DGlass/DTube));
/* Glass */
    WRadGlass[i] = F12*AGlass/Ns*sigma*EpsGlass*(Tglass[i]^(4) - Tsky^(4));
    WConvGlass[i] = AGlass/Ns*h*(Tglass[i] - Tatm);
    WAbsGlass[i] = PhiSun*AReflector/Ns*AlphaGlass*IAM*Gamma*R;
/* Glass balance */
    dM*cp_glass*der(Tglass[i]) = WAbsGlass[i] + WCondWall[i] + WConvWall[i] + WRadWall[i] - WConvGlass[i] - WRadGlass[i];
/* Flux to the pipe */
    -WTube[i] = OptEff*PhiSun*AReflector/Ns - WRadGlass[i] - WConvGlass[i];
  end for;
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-250, -60}, {130, 180}}, grid = {2, 2}, initialScale = 0.1), graphics = {Rectangle(extent = {{-230, 180}, {124, -44}}, lineColor = {255, 170, 85}, lineThickness = 0.5, fillColor = {184, 230, 255}, fillPattern = FillPattern.Solid), Polygon(points = {{-86, 11}, {-90, 1}, {-92, -3}, {-94, -7}, {-96, -11}, {-100, -15}, {-104, -19}, {-108, -23}, {-112, -27}, {-118, -31}, {-124, -35}, {-132, -37}, {-140, -39}, {-142, -39}, {-148, -39}, {-154, -39}, {-162, -39}, {-172, -37}, {-180, -35}, {-186, -33}, {-190, -31}, {-198, -27}, {-204, -23}, {-210, -17}, {-216, -11}, {-220, -5}, {-224, 3}, {-226, 9}, {-226, 11}, {-86, 11}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Polygon(points = {{118, 101}, {114, 91}, {112, 87}, {110, 83}, {108, 79}, {104, 75}, {100, 71}, {96, 67}, {92, 63}, {86, 59}, {80, 55}, {72, 53}, {64, 51}, {62, 51}, {56, 51}, {50, 51}, {42, 51}, {32, 53}, {24, 55}, {18, 57}, {14, 59}, {6, 63}, {0, 67}, {-6, 73}, {-12, 79}, {-16, 85}, {-20, 93}, {-22, 99}, {-22, 101}, {118, 101}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-126, -35}, {80, 55}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-226, 11}, {-22, 101}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-86, 11}, {118, 101}}, color = {0, 0, 0}, thickness = 0.5), Ellipse(extent = {{-164, 66}, {-150, 53}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-162, 64}, {-153, 55}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Line(points = {{-159, 66}, {45, 156}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-153, 54}, {51, 144}}, color = {0, 0, 0}, thickness = 0.5), Ellipse(extent = {{-166, -11}, {-148, -29}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Ellipse(extent = {{40, 156}, {54, 143}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {255, 255, 0}, fillPattern = FillPattern.Solid), Polygon(points = {{-158, 64}, {-152, 66}, {46, 154}, {50, 146}, {-154, 56}, {-158, 64}}, lineColor = {0, 127, 0}, lineThickness = 0.5, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Ellipse(extent = {{43, 154}, {52, 145}}, lineColor = {0, 127, 0}, lineThickness = 0.5, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Line(points = {{-156, 60}, {-156, -42}}, color = {255, 0, 0}, pattern = LinePattern.Dot), Line(points = {{48, 150}, {48, 48}}, color = {255, 0, 0}, pattern = LinePattern.Dot)}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-250, -60}, {130, 180}}, grid = {2, 2}, initialScale = 0.1), graphics = {Polygon(points = {{-86, 4}, {-90, -6}, {-92, -10}, {-94, -14}, {-96, -18}, {-100, -22}, {-104, -26}, {-108, -30}, {-112, -34}, {-118, -38}, {-124, -42}, {-132, -44}, {-140, -46}, {-142, -46}, {-148, -46}, {-154, -46}, {-162, -46}, {-172, -44}, {-180, -42}, {-186, -40}, {-190, -38}, {-198, -34}, {-204, -30}, {-210, -24}, {-216, -18}, {-220, -12}, {-224, -4}, {-226, 2}, {-226, 4}, {-86, 4}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Polygon(points = {{118, 94}, {114, 84}, {112, 80}, {110, 76}, {108, 72}, {104, 68}, {100, 64}, {96, 60}, {92, 56}, {86, 52}, {80, 48}, {72, 46}, {64, 44}, {62, 44}, {56, 44}, {50, 44}, {42, 44}, {32, 46}, {24, 48}, {18, 50}, {14, 52}, {6, 56}, {0, 60}, {-6, 66}, {-12, 72}, {-16, 78}, {-20, 86}, {-22, 92}, {-22, 94}, {118, 94}}, lineColor = {0, 0, 0}, lineThickness = 0.5), Line(points = {{-126, -42}, {80, 48}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-226, 4}, {-22, 94}}, color = {0, 0, 0}, thickness = 0.5), Line(points = {{-86, 4}, {118, 94}}, color = {0, 0, 0}, thickness = 0.5), Ellipse(extent = {{-168, 82}, {-142, 56}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {127, 0, 127}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-164, 78}, {-146, 60}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {0, 127, 0}, fillPattern = FillPattern.Solid), Line(points = {{-159, 81}, {45, 171}}, color = {0, 0, 0}, thickness = 0.5), Ellipse(extent = {{37, 172}, {63, 146}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {127, 0, 127}, fillPattern = FillPattern.Solid), Line(points = {{-149, 57}, {55, 147}}, color = {0, 0, 0}, thickness = 0.5), Polygon(points = {{-146, 72}, {-152, 84}, {44, 170}, {56, 148}, {-142, 60}, {-146, 72}}, lineColor = {127, 0, 127}, lineThickness = 0.5, fillColor = {127, 0, 127}, fillPattern = FillPattern.Solid), Polygon(points = {{-150, 78}, {-156, 82}, {-146, 86}, {-144, 78}, {-150, 78}, {-150, 78}}, lineColor = {127, 0, 127}, lineThickness = 0.5, fillColor = {127, 0, 127}, fillPattern = FillPattern.Solid), Polygon(points = {{-150, 58}, {-146, 64}, {-142, 66}, {-138, 62}, {-146, 58}, {-150, 58}}, lineColor = {127, 0, 127}, lineThickness = 0.5, fillColor = {127, 0, 127}, fillPattern = FillPattern.Solid), Ellipse(extent = {{-166, -18}, {-148, -36}}, lineColor = {0, 0, 0}, lineThickness = 0.5, fillColor = {215, 215, 215}, fillPattern = FillPattern.Solid), Rectangle(extent = {{-228, 173}, {120, -47}}, lineColor = {255, 170, 85}, lineThickness = 0.5)}),
    Window(x = 0.16, y = 0.03, width = 0.81, height = 0.9),
    Documentation(revisions = "
Authors  

Guillaume Larrignon  
Baligh El Hefni  
Benoît Bride   

    ", info = "
## Copyright © EDF 2002 - 2026  
## ThermoSysPro Version 4.2  
This component model is documented in Sect. 16.1 of the ThermoSysPro book.   

# Solar collector   

A PTSC receiver contains a parabolic reflective surface and a receiver  
tube, located at the surface focus line.  
The reflected solar energy is transfered to the transparent receiver tube, which contains an absorber tube coated with blackened nickel to ensure high absorption.  
The annulus gap between the absorber tube and the glass envelope is vacuumed in order to reduce heat losses to the ambient.  
The absorber tubes heat up the synthetic oil it contains to nearly 400 °C.  
The heat of the thermal oil is transfered by a heat exchanger to a water/steam cycle in order to produce electricity.  

The SolarCollector model is a steady-state model (accumulation is considered in  
the glass), based on first principle energy balance equations and on heat transfer phenomena occurring in PTSC receiver tube.  
The model takes into account heat losses from the receiver to the outside by radiation, conduction, and convection.  


## Modelica component model  

The equations mentioned below are implemented in the component *SolarCollector*, located in the *Solar.Collectors* sub-library.   
This component has 4 connectors:  
- AtmTemp: atmospheric temperature,  
- ISun: incident energy flow (Direct Normal Irradiation),  
- Incidence-Angle: angle between the sun and the zenith,  
- ITemperature: fluid temperature at the outlet.  

![modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Solar.Collectors.SolarCollector.svg](modelica://ThermoSysPro/UsersGuide/Documentation/ThermoSysPro.Solar.Collectors.SolarCollector.svg)  

## Nomenclature  

| Symbol| Description| Unit| Definition| Modelica name |  
| :----------------------------- | :---------------------------------------------- | :---------------------------------------- | :--------------------------- | :---------------------------------------- |  
| \\\\(A\\_{g, i}\\\\)| External glass surface for cell \\\\(i\\\\)| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\pi \\cdot\\left\\(D\\_{\\mathrm{g}}+2 . e\\right\\) \\cdot \\frac{L}{N}\\\\)| AGlass |  
| \\\\(A\\_{\\mathrm{r}}\\\\)| Reflector surface \\(Barakos 2006\\)| \\\\(\\mathrm{m}^{2}\\\\)| \\\\(4 f \\cdot \\tan \\left\\(\\frac{\\varphi\\_{\\mathrm{R}}}{2}\\right\\) \\cdot L\\\\) | AReflector |  
| \\\\(A\\_{\\mathrm{t}, i}\\\\)| External pipe surface \\(absorber\\) for cell \\\\(i\\\\) | \\\\(\\mathrm{m}^{2}\\\\)| \\\\(\\frac{\\pi \\cdot D \\cdot L}{N}\\\\)| ATube |  
| \\\\(c\\_{\\mathrm{p}, \\mathrm{g}}\\\\) | Specific heat capacity of the glass| \\\\(\\mathrm{J} / \\mathrm{kg} / \\mathrm{K}\\\\) | | cp_glass |  
| \\\\(D\\\\)| External pipe diameter (absorber) | \\\\(\\mathrm{m}\\\\)| | DTube |  
| \\\\(D\\_{\\mathrm{g}}\\\\)| Internal glass diameter| \\\\(\\mathrm{m}\\\\)| | DGlass |  
| \\\\(e\\\\)| Glass thickness or wall thickness| \\\\(\\mathrm{m}\\\\)| | e |  
| \\\\(f\\\\)| Focal length| \\\\(\\mathrm{m}\\\\)| | f |  
| \\\\(F\\_{12}\\\\)| View factor to surroundings \\(radiation heat loss\\)| \\\\(-\\\\)| |F12 |  
| \\\\(h\\_{\\mathrm{c}}\\\\) | Convective heat transfer coefficient between the ambient air and the glass envelop | \\\\(\\mathrm{W} / \\mathrm{m}^{2} / \\mathrm{K}\\\\) | | h |  
| \\\\(K\\\\)| Incidence angle modifier| \\\\(-\\\\)| \\\\(\\cos \\(\\theta\\)\\\\) | IAM |  
| \\\\(L\\\\)| Absorber pipe length| \\\\(\\mathrm{m}\\\\)| | L |  
| \\\\(m\\_{\\mathrm{g}}\\\\)| Glass mass for cell \\\\(i\\\\)| \\\\(\\mathrm{kg}\\\\) | \\\\(\\rho\\_{\\mathrm{g}} \\cdot \\frac{L}{N} \\cdot \\frac{\\pi}{4} \\cdot\\\\) \\\\(\\left\\(\\left\\(D\\_{\\mathrm{g}}+2 e\\right\\)^{2}-D\\_{\\mathrm{g}}^{2}\\right\\)\\\\) | dM |  
| \\\\(N\\\\)| Number of cells \\(segments\\)| \\\\(-\\\\)| | Ns |  
| \\\\(R\\\\)| Mirror reflectivity| \\\\(-\\\\)| | R |  
| \\\\(T\\_{\\text {atm }}\\\\)| Atmospheric temperature| \\\\(\\mathrm{K}\\\\)| | Tatm |  
| \\\\(T\\_{\\mathrm{g}, i}\\\\) | Glass temperature for cell \\\\(i\\\\)| \\\\(\\mathrm{K}\\\\)| | Tglass[i] |  
| \\\\(T\\_{\\mathrm{sky}}\\\\)| Sky temperature| \\\\(\\mathrm{K}\\\\)| \\\\(0.0552 \\cdot T\\_{\\mathrm{atm}}^{1.5}\\\\)| Tsky |  
| \\\\(T\\_{\\mathrm{w}, i}\\\\) | Temperature of the outer absorber surface for cell \\\\(i\\\\) | \\\\(\\mathrm{K}\\\\)| | Twall[i] |  
| \\\\(W\\_{\\text {abs }, g, i}\\\\)| Power absorption by the glass envelop for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | WAbsGlass[i] |  
| \\\\(W\\_{\\text {cond }, \\mathrm{tg}, i}\\\\) | Conduction power between the outer absorber surface and the inner glass surface for cell \\\\(i\\\\) | \\\\(\\mathrm{W}\\\\) | | WCondWall[i] |  
| \\\\(W\\_{\\text {conv,giair }, i}\\\\)| Convection power loss from the outer glass envelop surface to the ambient air for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | WConvWall[i] |  
| \\\\(W\\_{\\mathrm{rad}, \\mathrm{t}, i}\\\\)| Radiation power from the outer absorber surface and the inner glass surface for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | WRadWall[i] |  
| \\\\(W\\_{\\text {rad, g:sky }, i}\\\\) | Radiation power loss from the outer glass envelop surface to the sky for cell \\\\(i\\\\) | \\\\(\\mathrm{W}\\\\) | | WRadGlass[i] |  
| \\\\(W\\_{\\mathrm{t}, i}\\\\)| Total power transferred to the pipe \\(absorber\\) for cell \\\\(i\\\\)| \\\\(\\mathrm{W}\\\\) | | WTube[i] |  
| \\\\(\\alpha\\_{\\mathrm{g}}\\\\)| Glass absorptivity| \\\\(-\\\\) | | AlphaGlass |  
| \\\\(\\alpha\\_{\\mathrm{t}}\\\\)| Tube absorptivity| \\\\(-\\\\)| | AlphaN |  
| \\\\(\\gamma\\\\)| Interception factor| \\\\(-\\\\)| | Gamma |   
| \\\\(\\varepsilon\\_{\\mathrm{g}}\\\\)| Glass emissivity| \\\\(-\\\\) | | EpsGlass |  
| \\\\(\\varepsilon\\_{\\mathrm{t}}\\\\)| Tube emissivity| \\\\(-\\\\)| | EpsTube |  
| \\\\(\\eta\\_{\\text {opt }}\\\\)| Optical efficiency| \\\\(-\\\\)| | OptEff |  
| \\\\(\\theta\\\\)| Zenith angle| \\\\(^\\circ\\\\) | | Theta |  
| \\\\(\\lambda\\\\)| Gas thermal conductivity between the tube and the glass| \\\\(\\mathrm{W} /\\(\\mathrm{m} \\mathrm{K}\\)\\\\)| | Lambda |  
| \\\\(\\rho\\_{\\mathrm{g}}\\\\)| Glass density| \\\\(\\mathrm{kg} / \\mathrm{m}^{3}\\\\)|| rho_glass |   
| \\\\(\\sigma\\\\)| Stefan-Boltzmann constant| \\\\(\\left(\\mathrm{W} / \\mathrm{m}^{2} \\mathrm{K}^{4}\\right\\)\\\\) | \\\\(5.67 \\times 10^{-8}\\\\) | sigma |  
| \\\\(\\tau\\\\)| Glass transmissivity| \\\\(-\\\\)| | tauN |  
| \\\\(\\(\\tau \\alpha\\)\\_{n}\\\\)| Transmissivity-absorptivity factor| \\\\(-\\\\)| | TauAlphaN |  
| \\\\(\\varphi\\_{\\mathrm{R}}\\\\) | Rim angle| \\\\(^\\circ\\\\) | | RimAngle |  
| \\\\(\\phi\\_{\\text {sun }}\\\\)| Solar radiation \\(direct normal irradiance \\\\(-\\mathrm{DNI}\\\\) \\) | \\\\(\\mathrm{W} / \\mathrm{m}^{2}\\\\)|| PhiSun |  

## Governing equations  

### Solar radiation absorbed by the receiver \\(reflector total power\\)  


- Mathematical formulation:   
   
$$W\\_{\\mathrm{abs}, \\mathrm{t}}=\\eta\\_{\\mathrm{opt}} \\cdot \\phi\\_{\\mathrm{sun}} \\cdot A\\_{\\mathrm{r}}$$  

- Comments:   
   
The optical efficiency is given by   
\\\\(\\eta\\_{\\mathrm{opt}}=R \\cdot\\(\\tau \\alpha\\)\\_{n} \\cdot \\gamma \\cdot K\\\\).  The transmissivity-absorptivity factor is given by   
\\\\(\\(\\tau \\alpha\\)\\_{n}=\\tau \\cdot \\alpha \\cdot \\frac{1}{1-\\(1-\\alpha\\) \\cdot\\(1-\\tau\\)}\\\\), where \\\\(\\tau\\\\) is the transmissivity and \\\\(\\alpha\\\\) is the absorptivity.  

### Energy balance equation for the glass  

- Mathematical formulation:  

$$m_{\\mathrm{g}} \\cdot c_{\\mathrm{p}, \\mathrm{g}} \\cdot \\frac{\\mathrm{d} T_{\\mathrm{g}, i}}{\\mathrm{d} t} =W_{\\mathrm{abs}, \\mathrm{g}, i}+W_{\\mathrm{rad}, t, i}+W_{\\mathrm{cond}, \\mathrm{t}: \\mathrm{g}, i}-W_{\\mathrm{rad}, \\mathrm{g}: \\mathrm{s} \\mathrm{ky}, i}-W_{\\mathrm{conv}, \\mathrm{g}: \\mathrm{air}, i}$$  

- Comments:  

This equation calculates the glass temperature \\\\(T_{g,i}\\\\).  


###  Energy balance equation for the pipe (power transferred to the absorber)                                                        
- Mathematical formulation:  

$$W_{\\mathrm{t}, i}=\\frac{W_{\\mathrm{abs}, \\mathrm{t}}}{N}-W_{\\mathrm{rad}, \\mathrm{g}: \\mathrm{sky}, i}-W_{\\mathrm{conv}, \\mathrm{g}: \\mathrm{air}, i}$$  

- Comments:  

The net power received by each tube segment is equal to the total power absorbed by the receiver for that segment minus the losses by radiation to the sky and convection to the ambient for that segment.  


## References   
   
El Hefni, Baligh and Bouskela, Daniel (2019). [Modeling and Simulation of Thermal Power Plants with ThermoSysPro](https://link.springer.com/book/10.1007/978-3-030-05105-1), sect. 16.1. Springer Nature Switzerland AG.  
    "));
end SolarCollector;