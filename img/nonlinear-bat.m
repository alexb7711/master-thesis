1;

########################################################################################################################
# FUNCTIONS
########################################################################################################################

## usage: s_next = soc (s,D)
##
##
function s_next = soc (s,a,D)
  # Parameters
  k = 388;
  abar = exp(a*D);
  bbar = abar - 1;

  # Update SOC
  s_next = abar * s - bbar * k;
endfunction

## usage: y_vec = calc_y (x_vec, a, D)
##
##
function y_vec = calc_y (x_vec, a, D)
  y_vec = zeros(1, length(x_vec));
  y_vec(1) = 0;

  for i = 2:length(x_vec)
    y_vec(i) = soc(y_vec(i-1), a, D);
  endfor
endfunction

########################################################################################################################
# SCRIPT
########################################################################################################################
D = 1
x_vec = 0:D:650;
x_vec_plot = 0:D*0.01:650*0.01;

## Configure Plot
set(0, "defaultlinelinewidth", 4);
set(0, "defaultaxesfontsize", 16); % axes labels

## 0.01
a = -0.01;
y_vec = calc_y(x_vec, a, D);

size(x_vec)
size(y_vec)

hold;

p = plot(x_vec_plot,y_vec);

## 0.03
a = -0.03;
y_vec = calc_y(x_vec, a, D);

size(x_vec_plot)
size(y_vec)

p = plot(x_vec_plot,y_vec);

## 0.05
a = -0.05;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

## 0.1
a = -0.1;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

## Legend
l = legend({"-0.01", "-0.03", "-0.05", "-0.1"});
set(l, "fontsize", 20, "location", "southeast");

xlabel ("Time [hr]");
ylabel ("SOC [kWh]");

## Output plot
print(1, "nonlinear-bat.png");

waitfor(p);
