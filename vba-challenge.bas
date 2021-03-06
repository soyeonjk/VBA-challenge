Attribute VB_Name = "Module1"
Sub alphabetical_testing()
    ' LOOP THROUGH ALL SHEETS
Dim WS As Worksheet
    For Each WS In ActiveWorkbook.Worksheets
    WS.Activate
        ' Determine last row
        LastRow = WS.Cells(Rows.Count, 1).End(xlUp).Row

        ' Add heading
        Cells(1, 9).Value = "Ticker"
        Cells(1, 10).Value = "Yearly Change"
        Cells(1, 11).Value = "Percent Change"
        Cells(1, 12).Value = "Total Stock Volume"
        'Create variable
        Dim Yearly_Change As Double
        Dim Ticker_Symbol As String
        Dim Percent_Change As Double
        Dim Open_0 As Double
        Dim Close_0 As Double
        Dim Volume As Double
        Volume = 0
        Dim Row As Double
        Row = 2
        Dim Column As Integer
        Column = 1
        Dim i As Long
        
        'Set open price
        Open_0 = Cells(2, Column + 2).Value
         ' Loop through all ticker symbol
         For i = 2 To LastRow
         ' Check if we are still within the same ticker symbol, if it is not...
            If Cells(i + 1, Column).Value <> Cells(i, Column).Value Then
                ' Set Ticker name
                Ticker_Symbol = Cells(i, Column).Value
                Cells(Row, Column + 8).Value = Ticker_Symbol
                ' Set Close Price
                Close_0 = Cells(i, Column + 5).Value
                ' Add Yearly Change
                Yearly_Change = Close_0 - Open_0
                Cells(Row, Column + 9).Value = Yearly_Change
                ' Add Percent Change
                If (Open_0 = 0 And Close_0 = 0) Then
                    Percent_Change = 0
                ElseIf (Open_0 = 0 And Close_0 <> 0) Then
                    Percent_Change = 1
                Else
                    Percent_Change = Yearly_Change / Open_0
                    Cells(Row, Column + 10).Value = Percent_Change
                End If
                ' Add Total Volumn
                Volume = Volume + Cells(i, Column + 6).Value
                Cells(Row, Column + 11).Value = Volume
                ' Add one to the summary table row
                Row = Row + 1
                ' reset the Open Price
                Open_0 = Cells(i + 1, Column + 2)
                ' reset the Volumn Total
                Volume = 0
            'if cells are the same ticker
            Else
                Volume = Volume + Cells(i, Column + 6).Value
            End If
        Next i
        
        ' Determine the Last Row of Yearly Change per WS
        YCLastRow = WS.Cells(Rows.Count, Column + 8).End(xlUp).Row
         ' Set the Cell Colors
        For j = 2 To YCLastRow
            If (Cells(j, Column + 9).Value > 0 Or Cells(j, Column + 9).Value = 0) Then
                Cells(j, Column + 9).Interior.ColorIndex = 4
            ElseIf Cells(j, Column + 9).Value < 0 Then
                Cells(j, Column + 9).Interior.ColorIndex = 3
            End If
        Next j
    Next WS
End Sub

