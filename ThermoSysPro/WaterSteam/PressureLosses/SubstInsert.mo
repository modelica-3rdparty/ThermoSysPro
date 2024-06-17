within ThermoSysPro.WaterSteam.PressureLosses;
model SubstInsert "Insertion of substance"

    parameter Boolean use_ISub = false
    "Get the pressure from the input connector"
    annotation(Evaluate=true, HideResult=true, choices(checkBox=true));

    parameter Real Cin[Species.Concentrations]=zeros(size(C2.SubC,1)) "Fixed concentration values for the substances to be transported"
 annotation(Evaluate = true, Dialog(group="Transported Substances", enable = not use_ISub));



replaceable package Species =
      ThermoSysPro.ConvectedQuantities.Substances.None          annotation (
      choicesAllMatching=true, Dialog(tab="Fluid", group="Transported Substances"));


  parameter Boolean continuous_flow_reversal=false
    "true : continuous flow reversal - false : discontinuous flow reversal";

protected
    ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ISub_internal[Species.Concentrations]
    "Needed to connect to conditional connector";

    constant Real pi=Modelica.Constants.pi "pi";
    parameter Units.SI.MassFlowRate Qeps=1.e-3
      "Minimum mass flow for continuous flow reversal";


public
  WaterSteam.Connectors.FluidInlet C1(redeclare package Species = Species)
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  WaterSteam.Connectors.FluidOutlet C2(redeclare package Species = Species)                annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ISub[Species.Concentrations] if use_ISub
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},  rotation=-90,
        origin={0,50}),
                iconTransformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,50})));


equation

  connect(ISub, ISub_internal);

  if not use_ISub then
        ISub_internal[1:size(C2.SubC,1)].signal = Cin;
  end if;

  C2.SubC = C1.SubC + ISub_internal[1:size(C2.SubC,1)].signal;
  //C1.SubC = C2.SubC;

  C2.P = C1.P;
  C2.Q = C1.Q;
  C2.h = C1.h;




  /* Flow reversal */
  if continuous_flow_reversal then
    0 = noEvent(if (C1.Q > Qeps) then C1.h - C1.h_vol else if (C1.Q < -Qeps) then
      C2.h - C2.h_vol else C1.h - 0.5*((C1.h_vol - C2.h_vol)*Modelica.Math.sin(pi
      *C1.Q/2/Qeps) + C1.h_vol + C2.h_vol));
  else
    0 = if (C1.Q > 0) then C1.h - C1.h_vol else C2.h - C2.h_vol;
  end if;



  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-60,40},{60,-40}},
          lineColor={0,0,255},
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.09,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 13.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
", revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SubstInsert;
