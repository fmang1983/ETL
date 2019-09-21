$table = New-Object system.Data.DataTable

#Build Table Columns

$col1 = New-Object system.Data.DataColumn ("Address")
$col2 = New-Object system.Data.DataColumn ("City")
$col3 = New-Object system.Data.DataColumn ("MedianHouseValue")

$col4 = New-Object System.Data.DataColumn ("Zip")
$col5 = New-Object System.Data.DataColumn ("DistrictID")
$col6 = New-Object System.Data.DataColumn ("FacultyName")
$col7 = New-Object System.Data.DataColumn ("FacultyRole")
$col8 = New-Object System.Data.DataColumn ("FacultyStartDate")
$col9 = New-Object System.Data.DataColumn ("SchoolGrade")
$col10 = New-Object System.Data.DataColumn ("SchoolName")

$table.Columns.Add($col1)
$table.Columns.Add($col2)
$table.Columns.Add($col3)
$table.Columns.Add($col4)
$table.Columns.Add($col5)
$table.Columns.Add($col6)
$table.Columns.Add($col7)
$table.Columns.Add($col8)
$table.Columns.Add($col9)
$table.Columns.Add($col10)





Function GetAddressData
{
    Param(
        [Parameter(ValueFromPipeline = $true)]
        [Object[]]
        $Records
    )
    Process
    {
 
 $schoolcount=$Records[0].schoolDistrict.schools.count
$x = 0
while ($x -lt $schoolcount)
{
$row = $table.NewRow()
$row.Address= $Records[0].address
$row.City= $Records[0].city
$row.MedianHouseValue=$Records[0].MedianHouseValue
$row.Zip=$Records[0].Zip
$row.DistrictID=$Records[0].schoolDistrict.districtId
$row.FacultyName=$Records[0].schoolDistrict.schools[$x].faculty.name
$row.FacultyRole=$Records[0].schoolDistrict.schools[$x].faculty.role
$row.FacultyStartDate=$Records[0].schoolDistrict.schools[$x].faculty.startDate
$row.SchoolGrade=$Records[0].schoolDistrict.schools[$x].schoolGrade
$row.SchoolName=$Records[0].schoolDistrict.schools[$x].schoolName
$table.rows.add($row)


$x = $x + 1
}
    }
    }


#Point to Location of the API Output
$Output = Get-Content C:\Users\fmang\Downloads\sample_api_output.json | out-string | ConvertFrom-Json

<#check there is only 1 school distict convoluted
$x =0 

while ($x -lt $Output.Count)
{

$s = $Output[$x].schoolDistrict -as [string[]]

if ($s.Count > 1)
{
Write-Host $s.Count
}
$x = $x + 1

}
#>

$Cnt = 0


while ($Cnt -lt $Output.Count)
{
$Output[$Cnt]|GetAddressData
$Cnt = $Cnt + 1
}




$table|format-table -AutoSize | out-file .\Desktop\School.txt










