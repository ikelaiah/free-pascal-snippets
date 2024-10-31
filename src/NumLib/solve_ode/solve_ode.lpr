program solve_ode;

{$mode objfpc}{$H+}{$J-}

uses
  typ, // This unit contains common type definitions used in the program.
  ode; // This unit provides the ODE solver `odeiv1` used in the program.

// Define the function representing the differential equation: y' = f(x, y).
// In this case, f(x, y) = -10 * (y - x^2), a basic second-order ODE.
function f(x, y: ArbFloat): ArbFloat;
begin
  Result := -10 * (y - sqr(x)); // sqr(x) calculates x^2
end;

// Define the exact analytical solution for comparison purposes.
// The solution to the differential equation is given by y(x) = -0.02 * exp(-10 * x) + x^2 - 0.2 * x + 0.02.
function exact(x: real): real; far;
begin
  Result := -0.02 * exp(-10 * x) + sqr(x) - 0.2 * x + 0.02;
end;

const
  d = 0.5;  // The length of the interval over which to solve the ODE.
  ae = 1e-5; // The absolute error tolerance for the ODE solver.
  n = 10;    // The number of steps to take between the start and end of the interval.

var
  a, b, ya, yb: ArbFloat; // Variables representing the interval endpoints and function values.
  term: ArbInt;           // Variable to hold the error code returned by the ODE solver.
  i: ArbInt;              // Loop counter.

begin
  // Set initial conditions for the ODE solver.
  a := 0.0;      // Start at x = 0.
  b := a + d;    // End of the first step at x = 0.5 (the interval length).
  ya := 0.0;     // Initial condition: y(0) = 0.

  // Print table headers for output (x, y, exact solution, error code).
  WriteLn('x':12, 'y':12, 'exact':12, 'error code':17);
  WriteLn;

  // Output the initial condition at x = 0.
  WriteLn(a:12:5, ya:12:5, exact(a):12:5, '-':17); // Display the starting point.

  // Loop to solve the ODE in steps of 0.5 (controlled by 'd') until n steps are done.
  for i := 1 to n do
  begin
    // Call the ODE solver (odeiv1) to compute y(b) based on the function 'f'.
    // a: start of the interval, ya: initial value y(a), b: end of interval,
    // yb: result of y(b), ae: accuracy, term: error code.
    odeiv1(@f, a, ya, b, yb, ae, term);

    // Output the results after each step: x = b, y(b), exact solution, and error code.
    WriteLn(b:12:5, yb:12:5, exact(b):12:5, term:17);

    // Update for the next step: set a = b and ya = yb, and increment b by 'd' for the next interval.
    a := b;     // Move to the next interval.
    ya := yb;   // Use the computed value y(b) as the initial value for the next step.
    b := b + d; // Increment b for the next step.
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

