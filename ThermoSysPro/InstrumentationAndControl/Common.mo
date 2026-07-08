within ThermoSysPro.InstrumentationAndControl;

package Common
  extends ThermoSysPro.UsersGuide.Documentation.ThermoSysProPackageIcon;
  record Duree
    Integer nb_jours(min = 0) "Nombre de jours";
    Integer nb_heures(min = 0, max = 23) "Nombre d'heures";
    Integer nb_minutes(min = 0, max = 59) "Nombre de minutes";
    Integer nb_secondes(min = 0, max = 59) "Nombre de secondes";
    Integer nb_dixiemes_secondes(min = 0, max = 9) "Nombre de dixèmes de secondes";
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 50}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid), Text(extent = {{-127, 115}, {127, 55}}, textString = "%name"), Line(points = {{-100, -50}, {100, -50}}, color = {0, 0, 0}), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{0, 50}, {0, -100}}, color = {0, 0, 0})}),
      Window(x = 0.33, y = 0.33, width = 0.6, height = 0.6),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end Duree;

  record DateEtHeure
    Integer annee(min = 2000) "Année";
    Integer mois(min = 1, max = 12) "Mois dans l'année";
    Integer jour(min = 1, max = 31) "Jour dans le mois";
    Integer heure(min = 0, max = 23) "Heure du jour";
    Integer minutes(min = 0, max = 59) "Nombre de minutes";
    Integer secondes(min = 0, max = 59) "Nombre de secondes";
    Integer nb_dixemes_secondes(min = 0, max = 9) "Nombre de dixèmes de secondes";
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Rectangle(extent = {{-100, 50}, {100, -100}}, lineColor = {0, 0, 255}, fillColor = {255, 255, 127}, fillPattern = FillPattern.Solid), Text(extent = {{-127, 115}, {127, 55}}, textString = "%name"), Line(points = {{-100, -50}, {100, -50}}, color = {0, 0, 0}), Line(points = {{-100, 0}, {100, 0}}, color = {0, 0, 0}), Line(points = {{0, 50}, {0, -100}}, color = {0, 0, 0})}),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end DateEtHeure;

  function CvtEntierVersDuree
    input Integer t "Duree en dixiemes secondes";
    output Duree d "Duree" annotation(
      Placement(transformation(extent = {{-70, -70}, {70, 70}}, rotation = 0)));
  algorithm
    d.nb_jours := integer(t/24/3600/10);
    d.nb_heures := integer((t - d.nb_jours*24*3600*10)/3600/10);
    d.nb_minutes := integer((t - d.nb_jours*24*3600*10 - d.nb_heures*3600*10)/60/10);
    d.nb_secondes := integer((t - d.nb_jours*24*3600*10 - d.nb_heures*3600*10 - d.nb_minutes*60*10)/10);
    d.nb_dixiemes_secondes := integer(t - d.nb_jours*24*3600*10 - d.nb_heures*3600*10 - d.nb_minutes*60*10 - d.nb_secondes*10);
    annotation(
      Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}, grid = {2, 2}), graphics = {Ellipse(extent = {{-100, 40}, {100, -100}}, lineColor = {255, 127, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid), Text(extent = {{-84, -4}, {84, -52}}, lineColor = {255, 127, 0}, textString = "fonction"), Text(extent = {{-134, 104}, {142, 44}}, textString = "%name")}),
      Window(x = 0.27, y = 0.27, width = 0.6, height = 0.6),
      Documentation(info = "
## Copyright © EDF 2002 - 2026  


## ThermoSysPro Version 4.2  

      "));
  end CvtEntierVersDuree;
  annotation(Window(x = 0.05, y = 0.26, width = 0.25, height = 0.25, library = 1, autolayout = 1),
    Documentation(info = "
## Copyright © EDF 2002 - 2026  


Version 1.0  

    "));
end Common;