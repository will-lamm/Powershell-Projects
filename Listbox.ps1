function Select-Item 
{ 
PARAM  
( 
    [Parameter(Mandatory=$true)] 
    $options, 
    [Parameter(Mandatory=$false)] 
    $displayProperty 
) 

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Data Entry Form"
$form.Size = New-Object System.Drawing.Size(400,600) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,520)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,520)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(380,20) 
$label.Text = "Please make a selection from the list below:"
$form.Controls.Add($label) 

$listBox = New-Object System.Windows.Forms.Listbox 
$listBox.Location = New-Object System.Drawing.Point(10,40) 
$listBox.Size = New-Object System.Drawing.Size(360,420) 

$listBox.SelectionMode = "MultiExtended"

 #Populate ListBox 
    foreach ($option in $options) 
    { 
        $listBox.Items.Add($option)|out-null
    } 

$listBox.Height = 470
$form.Controls.Add($listBox) 
$form.Topmost = $True

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    return $x
}
}

$values = (Get-SwisData -SwisConnection $swis -Query "SELECT Name FROM Orion.APM.Application"|select -Unique |sort $_.Name)
#$values = "1","2","3","4"
$val = Select-Item -options $values
$val 