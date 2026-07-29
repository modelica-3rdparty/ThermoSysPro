within ThermoSysPro.NuclearCore.Modules;
model FuelThermalPower "Meshed model that describes the dynamic of the conduction of heat generated 
  by fission in a fuel rod."

  FuelProperties fuel[Nz,Nr](
    T=T,
    each porosity=fuel_porosity,
    each MOX=isMOX,
    each pu_mFraction=pu_mFraction,
    each oxy_on_metal=oxy_on_metal) "Fuel Properties";

  parameter Real fuel_porosity=0.05 "Fuel porosity" annotation(Dialog(group="Fuel Properties"));
  parameter Real oxy_on_metal=2 "Oxyde on Metal Ratio" annotation(Dialog(group="Fuel Properties"));
  parameter ThermoSysPro.Units.SI.Density rho_uo2=10950 "Density of UO2" annotation(Dialog(group="Fuel Properties"));
  parameter Boolean isMOX=false "Whether fuel is MOX or not" annotation(Dialog(group="Fuel Properties"));
  parameter Real pu_mFraction=0 "PuO2 Mass Fraction" annotation(Dialog(group="Fuel Properties",enable=isMOX));
  parameter ThermoSysPro.Units.SI.Density rho_puo2=11500 "Density of PuO2" annotation(Dialog(group="Fuel Properties",enable=isMOX));
  parameter ThermoSysPro.Units.SI.Density rho=(1-fuel_porosity)*1/(pu_mFraction/rho_puo2+(1-pu_mFraction)/rho_uo2) "Density of MOX" annotation(Dialog(group="Fuel Properties",enable=false));

  parameter Integer Rods_per_FA=264 "Number of fuel Rods per Fuel Assembly" annotation(Dialog(group="Geometry"));
  parameter Integer FA=193 "Radius of the fuel pellet" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius Rp=0.004095 "Radius of the fuel pellet" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius Rclad=0.00418 "Internal radius of the cladding" annotation(Dialog(group="Geometry"));
  parameter Integer Nz=6 "Number of axial zones" annotation(Dialog(group="Geometry"));
  parameter Integer Nr=5 "Number of radial zones" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Length Length=4.270 "Active lenght of the fuel rods" annotation(Dialog(group="Geometry"));
  parameter ThermoSysPro.Units.SI.Radius rsi[Nr]={sqrt(i*Rp^2/Nr) for i in 1:Nr} "Radii of volume skins (constant volume)" annotation(Dialog(group="Geometry",enable=false));
  parameter ThermoSysPro.Units.SI.Radius rvi[Nr]={sqrt((i-0.5)*Rp^2/Nr) for i in 1:Nr} "Radii of volume centers (constant volume)" annotation(Dialog(group="Geometry",enable=false));

  parameter Real zWt[Nz]={sin((i-0.5)*Lseg*pi/Length)/Length for i in 1:Nz}
    "Axial distribution of the thermal power produced in the zone i of the fuel";
  parameter Boolean steady_state=true annotation(choices(checkBox=true));
  parameter ThermoSysPro.Units.SI.Temperature Tstart=973.15;

  parameter ThermoSysPro.Units.SI.CoefficientOfHeatTransfer  heat_coeff_gap=10000
    "Heat Tranfer Coefficient between the fuel rods and the internal wall of the cladding";

protected
  parameter Integer Nrods=Rods_per_FA*FA "Number of fuel rods of UO2";
  parameter Real zWt_norm[Nz]=zWt / sum(zWt) "Normalized axial distribution of the thermal power produced in the zone i of the fuel";
  parameter ThermoSysPro.Units.SI.Length Lseg=Length/Nz "Lenght of the axial zones";
  parameter ThermoSysPro.Units.SI.Volume Mnode=Nrods*rho*pi*Rp*Rp*Lseg/Nr
    "Mass of fuel in each node";
  parameter ThermoSysPro.Units.SI.Area Sseg_cladi=Nrods*2*pi*Rclad*Lseg
    "Internal surface of the cladding in each segment";
  constant Real pi=Modelica.Constants.pi "Pi";

public

   ThermoSysPro.Units.SI.Temperature T[Nz, Nr] "Temperature of the fuel";
   ThermoSysPro.Units.SI.Temperature Tcenter[Nz] "Temperature at the center of the fuel";
   ThermoSysPro.Units.SI.Temperature Tout[Nz] "Temperature of surface of the fuel";

   ThermoSysPro.Units.SI.Temperature Teff[Nz](start=fill(Tstart, Nz))
    "Effective temperature of the UO2 per zone, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Teffg(start=Tstart)
    "Effective global temperature of the UO2, used for the calculation of the Doppler effect";
   ThermoSysPro.Units.SI.Temperature Tg[Nz](start=fill(Tstart, Nz))
    "Internal T of the cladding";

   //ThermoSysPro.Units.SI.Power W[Nz,Nr] "Power transmitted from the UO2 to the cladding in zone i";
  ThermoSysPro.Units.SI.Power Wt
    "Total thermal power produced by the UO2 fuel";
  ThermoSysPro.Units.SI.Power Wcond[Nz,Nr+1]
    "Thermal power exchanger between nodes by conduction";
  ThermoSysPro.Units.SI.LinearPowerDensity linW[Nz]=zWt_norm*Wt/Nrods/Length "Linear Power Density";

  ThermoSysPro.Thermal.Connectors.ThermalPort C_clad[Nz] annotation (Placement(transformation(extent={{100,-12},{120,10}},
          rotation=0), iconTransformation(extent={{100,-12},{120,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Wt_fuel
    annotation (Placement(transformation(extent={{-120,
            -10},{-100,10}}, rotation=0), iconTransformation(extent={{-120,-10},
            {-100,10}})));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Teff_fuel
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=90), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,110})));

initial equation
  if steady_state then
    for i in 1:Nz loop
      for j in 1:Nr loop
        der(T[i, j]) = 0;
      end for;
    end for;
  else
    for i in 1:Nz loop
      for j in 1:Nr loop
        T[i, j] = Tstart;
      end for;
    end for;
  end if;
equation
  -Wcond[:,end] =C_clad.W;
  Tg =C_clad.T;
  Wt =Wt_fuel.signal;
  Teffg =Teff_fuel.signal;

  Wcond[:,1] = zeros(Nz);  //Null thermal conduction power in the center
  Wcond[:,end] = heat_coeff_gap*Sseg_cladi*(Tout - Tg); //Convection power to the clad

  // Extrapolation of limit point (change in conductivities could be taken into account)
  Tcenter = T[:,1]*1.5 - T[:,2]*0.5;
  Tout = T[:,end]*1.5 - T[:,Nr-1]*0.5;

  for i in 1:Nz loop //Iterate on axial nodes

    for j in 1:Nr loop //Iterate on radial nodes

      //*** Energy balance in the fuel rods ***
      Mnode*fuel[i, j].cp*der(T[i, j]) = zWt_norm[i]*Wt/Nr + Wcond[i,j]-Wcond[i,j+1];

      if j<Nr then
        Wcond[i,j+1] = (fuel[i,j].k+fuel[i,j+1].k)/2 * (T[i,j]-T[i,j+1])/(rvi[j+1]-rvi[j]) * rsi[j]*pi*2*Lseg*Nrods;
      end if;

    end for;
  end for;

  // Calculation of the effective temperature in the zones (Rowlands correlation)
  Teff = 0.444*Tcenter + 0.556*Tout;
  // Mean effective temperature, weighted by thermal power axial distribution
  Teffg = zWt_norm * Teff;

  annotation (Diagram(
      coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
      graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}),
        Text(
          extent={{-72,96},{80,-96}},
          textColor={0,0,0},
          textString=
               "Uranium"),
        Text(
          extent={{-114,28},{-114,12}},
          textColor={0,0,255},
          textString=
               "Puo2"),
        Text(
          extent={{2,94},{2,78}},
          textColor={0,0,255},
          textString=
               "T_fuel")}),Icon(
      graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.VerticalCylinder,
          fillColor={255,128,0}), Text(
          extent={{-74,102},{82,-84}},
          textColor={0,0,0},
          textString=
        "%name")}),
    Documentation(info="# Fuel Heat Transfer

This module resolve the heat transfer equation in the fuel rod, based on the fuel properties, *cp* and *k*,
 computed in [FuelProperties](modelica://ThermoSysPro.NuclearCore.Modules.FuelProperties).

## Heat Transfer Resolution

The Finite Volumes approach is used, leading to the following equation for each node (axial thermal conduction is neglected):

$$Mnode*cp_{i,j}\\frac{dT_{i,j}}{dt} = W_{i,j} + Wcond_{i,j}-Wcond_{i,j+1}$$

where the radial themal conduction term is:

$$Wcond_{i,j+1} = \\frac{k_{i,j}+k_{i,j+1}}2 * \\frac{T_{i,j}-T_{i,j+1}}{rvi_{j+1}-rvi_j} * S_{i,j}$$

and where *i* is the axial index, *j* the radial index, *T* the temperature in the node, *S* the radial surface between two nodes,
 *Mnode* the mass in the node and *W* the power generated in the node.

It has to be noticed that the discretization is based on constant volumes, instead of constant radial steps; 
*rsi* is the radial coordinate of the volumes boundary, *rvi* the radial coordinate of the volumes centers (centers in volumic terms).

## Doppler Effect

The effective temperature used for the Doppler effect can be computed, for each axial section, using the Rowlands weighting function [1]:

$$T_{i,eff} = \\frac59T_{i,surface} + \\frac49T_{i,center}$$

then, weighted axially as a function of the generated power:

$$T_{effg} = \\frac{W_i}{W_T}*T_{i,eff} $$

To improve the the representativity of the *center* and *surface* temperatures, they are linearly extrapolated from the volume node temperature:

$$ T_{i,center} = T_{i,1}*1.5 - T_{i,2}*0.5 $$
$$ T_{i,surface} = T_{i,end}*1.5 - T_{i,end-1}*0.5 $$

The *linear* extrapolation is possible because of the constant volume discretization which give a linear solution under certains hypotheses 
(constant and homogenoeus power, constant conductivity). Under the same assomptions, it is also possible to compare the results in with the analytical solution [2]:

$$ T_{i,center}-T_{i,surface}=\\frac{W_i}{4\\pi k} $$

and thus validate the extrapolation of the *center* and *surface* values.

## Gap Heat Trasfer
For the gap, the following thermal convection equation is used, where \\\\(h_{gap}\\\\) is a user defined constant:

$$ Wcond_{i,end} = h_{gap} * S_{i,end} * (T_{i,surface} - T_{i,clad}) $$

- [1]. G. Rowlands, *Resonance absorption and non-uniform temperature distributions*, Journal of Nuclear Energy, 1962.
- [2]. N.E. Todreas, M. S. Kazimi, Nuclear System I, Thermal Hydraulics Fundamentals. Taylor&Francis, 1798.

## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  
"));
end FuelThermalPower;
