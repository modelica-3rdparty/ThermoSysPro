within ThermoSysPro.ConvectedQuantities.Components;
block MassBalance "Mass Balance block for transported substances"

  import      ThermoSysPro.Units.SI;

  replaceable package Species =
      Substances.None;

  parameter Integer n_in = 1 "Number of inlets";
  parameter Integer n_out = 1 "Number of outlets";

  Real InternalConcentrations[Species.Concentrations];
  Real in_Cflows[Species.Concentrations];
  SI.MassFlowRate out_Tflow;

  parameter Boolean dynamic_mass_balance = false "true: dynamic mass balance equation - false: static mass balance equation";
  parameter SI.Volume V = 0 "Volume used to compute the fluid mass for dynamic calculations"
                                                                                            annotation(Dialog(enable=dynamic_mass_balance));

  input MixtureConnector mix_in[n_in](redeclare package Species = Species)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  output MixtureConnector mix_out[n_out](redeclare package Species = Species)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
  input SI.MassFlowRate Qin[n_in];
  input SI.MassFlowRate Qout[n_out];

  input SI.Density rho;
initial equation

  if dynamic_mass_balance == true then
    der(InternalConcentrations) = zeros(size(InternalConcentrations,1));
  end if;

equation

    if dynamic_mass_balance == false then
      in_Cflows - out_Tflow * InternalConcentrations = zeros(size(InternalConcentrations,1));
    else
      in_Cflows - out_Tflow * InternalConcentrations = V*rho*der(InternalConcentrations) + InternalConcentrations*(sum(Qin)-out_Tflow);
    end if;

  out_Tflow = sum(Qout);
  for s in Species.Concentrations loop
    in_Cflows[s] = sum(Qin .* mix_in.SubC[s]);
  end for;

  for i in 1:n_out loop
    mix_out[i].SubC = InternalConcentrations;
  end for;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{40,20},{80,-20}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.14,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 14.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end MassBalance;
