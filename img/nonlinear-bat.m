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

## usage: soc = slow (x)
##
##
function soc = slow (x)
  soc = 30.0 * x/3600;

  for i = 1:length(x)
    if (soc(i) >= 388.0)
      soc(i) = 388.0;
    endif
  endfor
endfunction

## usage: soc = fast (x)
##
##
function soc = fast (x)
  soc =  910.95 * x/3600;

  for i = 1:length(x)
    if (soc(i) >= 388.0)
      soc(i) = 388.0;
    endif
  endfor
endfunction

########################################################################################################################
# SCRIPT
########################################################################################################################
HR2SEC = 3600;
SEC2HR = 1/HR2SEC;
HR = 15;
D = 1;
x_vec = 0:D:HR*HR2SEC;
x_vec_plot = SEC2HR * x_vec;


## Configure Plot
set(0, "defaultlinelinewidth", 4);
set(0, "defaultaxesfontsize", 16); % axes labels

## 0.01
a = -0.000025;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

hold;

## 0.03
a = -0.000043;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

## 0.05
a = -0.0005;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

## 0.1
a = -0.0012;
y_vec = calc_y(x_vec, a, D);

p = plot(x_vec_plot,y_vec);

## Linear
## y_vec = slow(x_vec);
## p = plot(x_vec_plot,y_vec);
##
## y_vec = fast(x_vec);
## p = plot(x_vec_plot,y_vec);
##
## e = 0.8*388;
## line([0 HR], [e, e], "linestyle", "--", "color", "red");

## Legend
l = legend({"-000025", "-0.000045", "-0.0005", "-0.002"});
## l = legend({"-000025",  "-0.0005", "-0.0012", "30", "910"});
set(l, "fontsize", 15, "location", "southeast");

xlabel ("Time [hr]");
ylabel ("SOC [kWh]");
axis([0 HR 0 390])

## Output plot
print(1, "nonlinear-bat.png");

waitfor(p);
