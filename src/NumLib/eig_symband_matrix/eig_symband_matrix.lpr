program eig_symband_matrix;

{$mode objfpc}{$H+}{$J-}

uses
  SysUtils, math,
  typ, eig;

const
  n_mat_size = 7;    // Size of the matrix (n x n matrix)
  w_band_size = 2;   // Bandwidth of the matrix (how many diagonals on either side of the main diagonal)

  // Total number of elements in the 1D array representing the matrix's diagonals
  n_diag_elements = n_mat_size * (w_band_size + 1) - (w_band_size * (w_band_size + 1)) div 2;

  decimal_place = 3; // Number of decimal places for output

// Converts a matrix index (i, j) into the corresponding 1D array index for a band matrix
function MatrixIndexToArrayIndex(i, j, n, w: Integer): Integer;

  // Calculates the starting index for a given diagonal element
  function DiagElementIndex(i: Integer): Integer;
  var
    k: Integer;
  begin
    Result := 1;
    if i = 1 then
      exit;
    // For diagonals truncated at the left side of the matrix
    for k := 2 to w do begin
      Result := Result + k;
      if k = i then
        exit;
    end;
    // For full rows and diagonals truncated on the right side
    for k := w+1 to n do begin
      Result := Result + w + 1;
      if k = i then
        exit;
    end;
    Result := n;
  end;

var
  d: Integer;
begin
  // Ensures that we always access the upper diagonal by swapping (i, j) if necessary
  if j > i then begin
    Result := MatrixIndexToArrayIndex(j, i, n, w);
    exit;
  end;

  // Get the starting index of the diagonal element in the 1D array
  Result := DiagElementIndex(i);

  // If i = j, we are on the main diagonal
  if (i = j) then
    exit;

  // Calculate the offset for the element in the band
  d := i - j;
  if d > w then
    Result := -1 // Element is outside the bandwidth, return -1 to indicate zero
  else begin
    dec(Result, d); // Adjust the index for the diagonal element
    if (Result < 1) then
      Result := -1; // Invalid index (out of bounds)
  end;
end;

var
  // Array to hold the elements of the banded matrix (diagonal and left band)
  mat_a: array[1..n_diag_elements] of ArbFloat = (
     5,   // Main diagonal element (row 1, col 1)
    -4, 6,   // Row 2 (left band and main diagonal)
     1, -4, 6,   // Row 3 (two left band, main diagonal)
         1, -4, 6,   // Row 4, (two left band, main diagonal)
             1, -4, 6,  // Row 5, the same ...
                 1, -4, 6,
                     1, -4, 5 );

  // Array to store the calculated eigenvalues
  eig_values_lambda: array[1..n_mat_size] of ArbFloat;

  // Matrix to store the calculated eigenvectors
  eig_vectors_mat_x: array[1..n_mat_size, 1..n_mat_size] of ArbFloat;

  term: integer = 0; // Variable for capturing the result of the eigenvalue/eigenvector calculation
  i, j, k: integer;  // Loop counters

begin
  // Display matrix information
  WriteLn('n = ', n_mat_size);
  Writeln('(One-sided) band width w = ', w_band_size);

  // Print diagonal elements of the band matrix
  Write('Diagonal elements of A = ', mat_a[1]:0:0);
  for k := 2 to n_diag_elements do
    Write(mat_a[k]:3:0);
  WriteLn;
  WriteLn;

  // Reconstruct and display the full symmetric band matrix from the 1D array (for verification purposes)
  WriteLn('Reconstructed A = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do begin
      k := MatrixIndexToArrayIndex(i, j, n_mat_size, w_band_size); // Get the 1D array index for the element (i, j)
      if k = -1 then
        Write(0.0:3:0) // Print 0 if the element is outside the band
      else
        Write(mat_a[k]:3:0); // Print the matrix element
    end;
    WriteLn;
  end;
  WriteLn;

  // Call NumLib to calculate all eigenvalues and eigenvectors (eigbs3)
  eigbs3(mat_a[1], n_mat_size, w_band_size, eig_values_lambda[1], eig_vectors_mat_x[1,1], n_mat_size, term);

  // Check if the calculation was successful
  if term <> 1 then begin
    WriteLn('term = ', term, ' --> ERROR'); // Error message in case of failure
    halt;
  end;

  // Display expected eigenvalues for reference (example)
  WriteLn('Expected eigenvalues:');
  for i := 1 to n_mat_size do
    Write(16 * intpower(sin(i*pi/16), 4):15:decimal_place); // Compute and print expected eigenvalues
  WriteLn;
  WriteLn;

  // Print the calculated eigenvalues
  WriteLn('Calculated eigenvalues: lambda = ');
  for i := 1 to n_mat_size do
    Write(eig_values_lambda[i]:15:decimal_place); // Print each eigenvalue
  WriteLn;
  WriteLn;

  // Print the calculated eigenvectors (one per column)
  WriteLn('Eigenvectors (as columns): x = ');
  for i := 1 to n_mat_size do begin
    for j := 1 to n_mat_size do
      Write(eig_vectors_mat_x[i, j]:15:decimal_place); // Print each element of the eigenvector matrix
    WriteLn;
  end;

  // Pause to allow user to see results before exiting the program
  WriteLn('Press enter to quit');
  ReadLn;
end.

