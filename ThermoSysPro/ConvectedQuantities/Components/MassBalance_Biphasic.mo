within ThermoSysPro.ConvectedQuantities.Components;
partial block MassBalance_Biphasic
  "Mass Balance block for transported substances"

  // Varibles resine. A enlever ? --------------------
  constant Real pi=Modelica.Constants.pi "pi";
  parameter SI.Length L=1;
  parameter SI.Length D=1;
  parameter Real capa=1;
  //----------------



  import      ThermoSysPro.Units.SI;

  replaceable package Species =
      Substances.None;

  replaceable package SinkAndSource =
      Sink_and_Source.None;

  parameter Integer n_in = 1 "Number of inlets";
  parameter Boolean dynamic_mass_balance = false "true: dynamic mass balance equation - false: static mass balance equation";
  parameter Boolean steady_state = true "true: start from steady state - false: start from (C0)";
  //parameter Species.sink_and_source_list sink_and_source = Species.sink_and_source_list.none;
  parameter Real C0[Species.Concentrations] = zeros(size(InternalConcentrations,1)) "Initial Concentrations (active if steady_state=false)";
  parameter SI.Volume V = 0 "Volume used to compute the fluid mass for dynamic calculations"
                                                                                            annotation(Dialog(enable=dynamic_mass_balance));

  Real InternalConcentrations[Species.Concentrations];
  Real in_Cflows[Species.Concentrations];
  SI.MassFlowRate out_Tflow_gas;
  SI.MassFlowRate out_Tflow_liq;

  input SI.MassFlowRate Qin[n_in];
  input SI.Density rho;
  input SI.Density rho_liquidPhase;
  input Real x "Title";
  input SI.Temperature T "Fluid Temperature";
  input SI.Volume Vl = 0 "Volume of the liquidPhase";

  input ThermoSysPro.ConvectedQuantities.Components.MixtureConnector mix_in[
    n_in](redeclare package Species = Species) annotation (Placement(
        transformation(extent={{-70,-10},{-50,10}}), iconTransformation(extent=
            {{-70,-10},{-50,10}})));
  Species.PhasesSeparation phasesSeparation(T=T, rho_liquidPhase=rho_liquidPhase, x=x, SubC=InternalConcentrations)
    annotation (Placement(transformation(extent={{-100,40},{-40,100}})));
  SinkAndSource.SaS_None SaS(
  T=T,
  SubC = phasesSeparation.Cl,
  Q=sum(Qin),
  capa=capa,
  S=pi*D^2/4,
  rho_liquidPhase=rho_liquidPhase,
  x=0,
  choix_resine=1,
  D=D,
  L=L)
    annotation (Placement(transformation(extent={{100,-40},{40,-100}})));


//   Species.Sink_and_Source Sink_and_Source(
//   T=T,
//   SubC = phasesSeparation.Cl)
//     annotation (Placement(transformation(extent={{100,-40},{40,-100}})));




initial equation

  if dynamic_mass_balance == true then
    if steady_state then
      der(InternalConcentrations) = zeros(size(InternalConcentrations,1));
    else
      InternalConcentrations = C0;
    end if;
  end if;

equation

//     if dynamic_mass_balance == false then
//       if sink_and_source == Species.sink_and_source_list.degradation then
//         in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = zeros(size(InternalConcentrations,1));
//       else
//         in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = zeros(size(InternalConcentrations,1)) + Vl*rho_liquidPhase*Sink_and_Source.C;
//       end if;
//     else
//       if sink_and_source == Species.sink_and_source_list.degradation then
//         in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = V*rho*der(InternalConcentrations) + InternalConcentrations*(sum(Qin)-out_Tflow_gas-out_Tflow_liq);
//       else
//         in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = V*rho*der(InternalConcentrations) + InternalConcentrations*(sum(Qin)-out_Tflow_gas-out_Tflow_liq) + Vl*rho_liquidPhase*Sink_and_Source.C;
//       end if;
//     end if;

    if dynamic_mass_balance == false then
        in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = zeros(size(InternalConcentrations,1)) + Vl*rho_liquidPhase*SaS.C;
    else
        in_Cflows - out_Tflow_liq*phasesSeparation.Cl - out_Tflow_gas*phasesSeparation.Cg = V*rho*der(InternalConcentrations) + InternalConcentrations*(sum(Qin)-out_Tflow_gas-out_Tflow_liq) + Vl*rho_liquidPhase*SaS.C;
    end if;



  for s in Species.Concentrations loop
    in_Cflows[s] = sum(Qin .* mix_in.SubC[s]);
  end for;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-62,60},{58,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{20,-22},{60,-62}},
          lineColor={28,108,200},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
                               Rectangle(
          extent={{20,62},{60,22}},
          lineColor={238,46,47},
          fillColor={255,170,170},
          fillPattern=FillPattern.CrossDiag),
                                          Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,0},{58,14},{54,26},{48,36},{38,46},{26,54},{14,58},{0,60},
              {0,0},{60,0}},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-60,0},{-58,14},{-54,26},{-48,36},{-38,46},{-26,54},{-14,58},
              {0,60},{0,0},{-60,0}},
          fillColor={170,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None)}),
    Window(
      x=0.14,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
<p><b>ThermoSysPro Version 2.0</b></p>
<p>This component model is documented in Sect. 14.1 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>l
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end MassBalance_Biphasic;
