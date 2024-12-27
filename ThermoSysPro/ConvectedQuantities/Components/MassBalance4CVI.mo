within ThermoSysPro.ConvectedQuantities.Components;
block MassBalance4CVI "Mass Balance block for transported substances"

  import      ThermoSysPro.Units.SI;
  constant Real pi=Modelica.Constants.pi "pi";

  replaceable package Species =
      ThermoSysPro.ConvectedQuantities.Substances.None
                      annotation (
  choicesAllMatching=true);

  //replaceable package SinkAndSource =
      //Sink_and_Source.None;

  replaceable ThermoSysPro.ConvectedQuantities.Components.SaSnone SaS
    constrainedby ThermoSysPro.ConvectedQuantities.Components.partialSaS(
      SubC=InternalConcentrations,
      T=T,
      Q=sum(Qin),
      capa=capa,
      S=pi*D^2/4,
      rho_liquidPhase=rho,
      choix_resine=1,
      L=L) "Sink and Source of Species"
    annotation (
  choicesAllMatching=true);

  parameter Integer n_in = 1 "Number of inlets";
  parameter Integer n_out = 1 "Number of outlets";
  parameter SI.Length D=1 annotation(Dialog(enable = (sink_and_source == Species.sink_and_source_list.resine)));
  parameter SI.Length L=1 annotation(Dialog(enable = (sink_and_source == Species.sink_and_source_list.resine)));
  parameter Real capa=1 annotation(Dialog(enable = (sink_and_source == Species.sink_and_source_list.resine)));
  //parameter Real choix_resine=1;

  Real InternalConcentrations[Species.Concentrations];
  Real in_Cflows[Species.Concentrations];
  SI.MassFlowRate out_Tflow;

  //Real dist[Species.Concentrations](start=fill(0,size(InternalConcentrations,1)), fixed=true);
  //Real t_sat[Species.Concentrations];
  //parameter Species.sink_and_source_list sink_and_source = Species.sink_and_source_list.none;

  parameter Boolean dynamic_mass_balance = false "true: dynamic mass balance equation - false: static mass balance equation";
  parameter SI.Volume V = 10 "Volume used to compute the fluid mass for dynamic calculations and for degradation";

  input ThermoSysPro.ConvectedQuantities.Components.MixtureConnector mix_in[n_in](
      redeclare package Species = Species)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  output ThermoSysPro.ConvectedQuantities.Components.MixtureConnector mix_out[n_out](
      redeclare package Species = Species)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  input SI.MassFlowRate Qin[n_in];
  input SI.MassFlowRate Qout[n_out];

  input SI.Density rho;
  input SI.Temperature T;
  input Real NH3_CVI;

//   SinkAndSource.SaS_None SaS(
//     SubC=InternalConcentrations,
//     T=T,
//     Q=sum(Qin),
//     capa=capa,
//     S=pi*D^2/4,
//     rho_liquidPhase=rho,
//     x=0,
//     choix_resine=1,
//     L=L,
//     D=D)           annotation (Placement(transformation(extent={{-100,60},{-60,100}})));

//   Species.Sink_and_Source SaS_degradation(
//     T=T,
//     SubC=InternalConcentrations)
//     annotation (Placement(transformation(extent={{-100,60},{-60,100}})));
//   Species.Sink_and_Source_1 SaS_resine(
//     SubC=InternalConcentrations,
//     T=T,
//     Q=sum(Qin[n_in]),
//     capa=capa,
//     S=pi*D^2/4,
//     rho_liquidPhase=rho,
//     x=0,
//     choix_resine=1)
//     annotation (Placement(transformation(extent={{60,-100},{100,-60}})));

initial equation

   if dynamic_mass_balance == true then
    der(InternalConcentrations) = zeros(size(InternalConcentrations,1));
   end if;

equation

    if dynamic_mass_balance == false then
      in_Cflows - out_Tflow * InternalConcentrations = NH3_CVI*SaS.C;
    else
      in_Cflows - out_Tflow * InternalConcentrations = V*rho*der(InternalConcentrations) + InternalConcentrations*(sum(Qin)-out_Tflow) + NH3_CVI*SaS.C;
    end if;

//     dist=zeros(size(InternalConcentrations,1));
//     t_sat=zeros(size(InternalConcentrations,1));
//

//  if sink_and_source == Species.sink_and_source_list.resine then
//     der(dist)=SaS.v;
//     for s in Species.Concentrations loop
//       if abs(SaS.v[s])<1e-18 then
//           t_sat[s]=0;
//       else
//           t_sat[s]=L/(60*60*24*SaS.v[s]);
//       end if;
//     end for;

  out_Tflow = sum(Qout);

  for s in Species.Concentrations loop
    in_Cflows[s] = sum(Qin .* mix_in.SubC[s]);
  end for;

//   for i in 1:n_out loop
//     for s in Species.Concentrations loop

//       if dist[s]>=L then
//         mix_out[i].SubC[s] = InternalConcentrations[s];
//       else
//         mix_out[i].SubC[s] = 0;
//       end if;

//     end for;
//   end for;

  for i in 1:n_out loop
    for s in Species.Concentrations loop
        mix_out[i].SubC[s] = InternalConcentrations[s]*SaS.SatRes[s];
    end for;
  end for;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Ellipse(
          extent={{-62,60},{58,-60}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360)}),
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
end MassBalance4CVI;
