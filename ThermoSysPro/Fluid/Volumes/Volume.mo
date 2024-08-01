within ThermoSysPro.Fluid.Volumes;
model Volume "Mixing volume with n inlets and m outlets"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeParameterInterface;
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Boolean dynamic_energy_balance=true
    "true: dynamic energy balance equation - false: static energy balance equation";
  parameter Units.SI.Volume V=1
    "Volume (active if dynamic_energy_balance=true)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Boolean dynamic_mass_balance=false
    "true: dynamic mass balance equation - false: static mass balance equation (active if the fluid is compressible and if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=isCompressible and dynamic_energy_balance));
  parameter Boolean steady_state=true
    "true: start from steady state - false: start from (P0, h0) (active if dynamic_energy_balance=true)" annotation(Evaluate=true, Dialog(enable=dynamic_energy_balance));
  parameter Units.SI.AbsolutePressure P0=1e5
    "Initial fluid pressure (active if the fluid is compressible, and if dynamic_energy_balance=true and dynamic_mass_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=isCompressible and
          dynamic_energy_balance and dynamic_mass_balance and not steady_state));
  parameter Units.SI.SpecificEnthalpy h0=1e5
    "Initial fluid specific enthalpy (active if dynamic_energy_balance=true and steady_state=false)"
    annotation (Evaluate=true, Dialog(enable=dynamic_energy_balance and not
          steady_state));
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Boolean diffusion=false
    "true: energy balance equation with diffusion - false: energy balance equation without diffusion";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter Boolean dynamic_composition_balance=false
    "<html>true: dynamic fluid composition balance equation <br>false: static fluid composition balance equation (active for flue gases)</html>" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.FlueGases), tab="Fluid", group="Fluid properties"));
  parameter Integer nInletPorts = 0 "Number of inlet fluid port" annotation (
    Dialog(connectorSizing = true));
    parameter Integer nOutletPorts = 0 "Number of outlet fluid port" annotation (
    Dialog(connectorSizing = true));
  parameter ThermoSysPro.Units.SI.MassFraction Xco20=0.0
    "Initial CO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xh2o0=if ftype == FluidType.FlueGases then 0.05 else 0
    "Initial H20 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xo20=0.23
    "Initial O2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));
  parameter ThermoSysPro.Units.SI.MassFraction Xso20=0
    "Initial SO2 mass fraction" annotation (Evaluate=true, Dialog(
      enable=dynamic_composition_balance,
      tab="Fluid",
      group=
          "Initial composition values (active for flue gases only if dynamic_composition_balance=true)"));

protected
  constant Units.SI.SpecificEnthalpy hr=2501569
    "Water/steam reference specific enthalpy at 0.01°C";
  parameter Boolean flue_gases=(ftype == FluidType.FlueGases) "Flue gases";
  parameter Units.SI.MassFlowRate gamma0=1.e-4
    "Pseudo-diffusion conductance use for continuous flow reversal (active if diffusion=false and continuous_flow_reversal = true)";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure P(start=1.e5) "Fluid pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.MassFlowRate BQ "Right hand side of the mass balance equation";
  Units.SI.Power BH "Right hand side of the energy balance equation";
  Units.SI.DerDensityByPressure ddph
    "density derivative wrt pressure at constant specific enthalpy";
  Units.SI.DerDensityByEnthalpy ddhp
    "density derivative wrt specific enthalpy at constant pressure";
  FluidType fluids[nInletPorts+nOutletPorts+1] "Fluids mixing in volume";
  Units.SI.MassFlowRate BXco2 "Right hand side of the CO2 balance equation";
  Units.SI.MassFlowRate BXh2o "Right hand side of the H2O balance equation";
  Units.SI.MassFlowRate BXo2 "Right hand side of the O2 balance equation";
  Units.SI.MassFlowRate BXso2 "Right hand side of the SO2 balance equation";
  ThermoSysPro.Units.SI.MassFraction Xco2 "CO2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xh2o "H20 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xo2 "O2 mass fraction";
  ThermoSysPro.Units.SI.MassFraction Xso2 "SO2 mass fraction";
  Units.SI.Power Je[nInletPorts] "Thermal power diffusion from inlets";
  Units.SI.Power Js[nOutletPorts] "Thermal power diffusion from outlets";
  Units.SI.Power J "Total thermal power diffusion";
  Units.SI.MassFlowRate gamma_e[nInletPorts] "Diffusion conductance for inlets";
  Units.SI.MassFlowRate gamma_s[nOutletPorts] "Diffusion conductance for outlets";
  Real re[nInletPorts] "Value of r(Q/gamma) for inlets";
  Real rs[nOutletPorts] "Value of r(Q/gamma) for outlets";

public
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Ce[nInletPorts] annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cs[nOutletPorts] annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
initial equation
  if dynamic_energy_balance and dynamic_mass_balance then
    if steady_state then
      der(P) = 0;
    else
      P = P0;
    end if;
  end if;

  if dynamic_energy_balance then
    if steady_state then
      der(h) = 0;
    else
      h = h0;
    end if;
  end if;

  if flue_gases then
    if dynamic_composition_balance then
      if steady_state then
        der(Xco2) = 0;
        der(Xh2o) = 0;
        der(Xo2) = 0;
        der(Xso2) = 0;
      else
        Xco2 = Xco20;
        Xh2o = Xh2o0;
        Xo2 = Xo20;
        Xso2 = Xso20;
      end if;
    end if;
  end if;

equation
  /* Check that volume is positive */
  if dynamic_energy_balance or dynamic_mass_balance then
    assert(V > 0, "Volume non-positive");
  end if;

  /* Check that incoming fluids are compatible with fluid in volume */
  fluids[1] = ftype;
  for i in 1:nInletPorts loop
    fluids[1+i] = Ce[i].ftype;
    P = Ce[i].P;
    Ce[i].h_vol_2 = h;

    Ce[i].diff_res_2 = 0;
    Ce[i].diff_on_2 = diffusion;
  end for;

  for i in 1:nOutletPorts loop
    fluids[1+nInletPorts+i] = Cs[i].ftype;
    P = Cs[i].P;
    Cs[i].h_vol_1 = h;

    Cs[i].ftype = ftype;
    Cs[i].Xco2 = Xco2;
    Cs[i].Xh2o = Xh2o;
    Cs[i].Xo2  = Xo2;
    Cs[i].Xso2 = Xso2;

    Cs[i].diff_res_1 = 0;
    Cs[i].diff_on_1 = diffusion;
  end for;

  assert(ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.isCompatible(fluids),
    "VolumeA: fluids mixing in volume are not compatible with each other");

  /* Mass balance equation */
  BQ = sum(Ce.Q) - sum(Cs.Q);

  if isCompressible and dynamic_energy_balance and dynamic_mass_balance then
    V*(ddph*der(P) + ddhp*der(h - Xh2o*hr)) = BQ;
  else
    0 = BQ;
  end if;

  /* Energy balance equation */
  BH = sum(Ce.Q.*(Ce.h-Ce.Xh2o*hr))-sum(Cs.Q.*(Cs.h-Cs.Xh2o*hr)) + J;

  if dynamic_energy_balance then
    if dynamic_mass_balance then
      V*(((h - Xh2o*hr)*ddph - 1)*der(P) + ((h - Xh2o*hr)*ddhp + rho)*der(h - Xh2o*hr)) = BH;
    else
      V*rho*der(h - Xh2o*hr) = BH;
    end if;
  else
    BH = 0;
  end if;

  /* Fluid composition balance equations */
  BXco2 = sum(Ce.Xco2.*Ce.Q)-sum(Cs.Xco2.*Cs.Q);
  BXh2o = sum(Ce.Xh2o.*Ce.Q)-sum(Cs.Xh2o.*Cs.Q);
  BXo2 = sum(Ce.Xo2.*Ce.Q)-sum(Cs.Xo2.*Cs.Q);
  BXso2 = sum(Ce.Xso2.*Ce.Q)-sum(Cs.Xso2.*Cs.Q);

  if flue_gases then
    if dynamic_composition_balance then
      V*rho*der(Xco2) + Xco2*BQ = BXco2;
      V*rho*der(Xh2o) + Xh2o*BQ = BXh2o;
      V*rho*der(Xo2)  + Xo2*BQ  = BXo2;
      V*rho*der(Xso2) + Xso2*BQ = BXso2;
    else
      Xco2*BQ = BXco2;
      Xh2o*BQ = BXh2o;
      Xo2*BQ  = BXo2;
      Xso2*BQ = BXso2;
    end if;
  else
    Xco2 = 0;
    Xh2o = 0;
    Xo2 = 0;
    Xso2 = 0;
  end if;

  /* Flow reversal */
  if continuous_flow_reversal then
    for i in 1:nOutletPorts loop
      Cs[i].h = ThermoSysPro.Functions.SmoothCond(Cs[i].Q/gamma_s[i], Cs[i].h_vol_1, Cs[i].h_vol_2, 1);
    end for;
  else
    for i in 1:nOutletPorts loop
      Cs[i].h = if (Cs[i].Q > 0) then Cs[i].h_vol_1 else Cs[i].h_vol_2;
    end for;
  end if;

  /* Diffusion power */
  if diffusion then
    for i in 1:nInletPorts loop
      re[i] = if Ce[i].diff_on_1 then exp(-0.033*(Ce[i].Q*Ce[i].diff_res_1)^2) else 0;
      gamma_e[i] = if Ce[i].diff_on_1 then 1/Ce[i].diff_res_1 else gamma0;
      Je[i] = if Ce[i].diff_on_1 then re[i]*gamma_e[i]*(Ce[i].h_vol_1 - Ce[i].h_vol_2) else 0;
    end for;
    for i in 1:nOutletPorts loop
      rs[i] = if Cs[i].diff_on_1 then exp(-0.033*(Cs[i].Q*Cs[i].diff_res_2)^2) else 0;
      gamma_s[i] = if Cs[i].diff_on_2 then 1/Cs[i].diff_res_2 else gamma0;
      Js[i] = if Cs[i].diff_on_2 then rs[i]*gamma_s[i]*(Cs[i].h_vol_2 - Cs[i].h_vol_1) else 0;
    end for;
  else
    for i in 1:nInletPorts loop
      re[i] = 0;
      gamma_e[i] = gamma0;
      Je[i] = 0;
    end for;
    for i in 1:nOutletPorts loop
      rs[i] = 0;
      gamma_s[i] = gamma0;
      Js[i] = 0;
    end for;
  end if;

  J = sum(Je)+sum(Js);

  /* Fluid thermodynamic properties */
  if isCompressible and dynamic_mass_balance then
    ddph = ThermoSysPro.Properties.Fluid.Density_derp_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
    ddhp = ThermoSysPro.Properties.Fluid.Density_derh_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  else
    ddph = 0;
    ddhp = 0;
  end if;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(P, h, fluid, mode, Xco2, Xh2o, Xo2, Xso2);
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{90,0}}, color={0,0,255}),
         Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor={85,170,255},
          lineThickness=0.2)}),
   Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-90,0},{90,0}},
          color={28,108,200},
          thickness=0.2),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={28,108,200},
          lineThickness=0.2,
          fillPattern=DynamicSelect(FillPattern.Solid,
          if dynamic_mass_balance and dynamic_energy_balance then FillPattern.Sphere
          else FillPattern.Solid),
          fillColor=DynamicSelect({85,170,255},
          if dynamic_energy_balance then fill_color_dynamic
          else if diffusion then fill_color_singular
          else fill_color_static))}),
    Window(
      x=0.14,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 14.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end Volume;
