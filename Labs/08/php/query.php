<?php
include("dbcon.php");

$firstName = $lastName = $age = "";
$firstNameErr = $lastNameErr = $ageErr = $imageErr = "";

if (isset($_POST['addStudent'])) {
    $firstName = $_POST['first_name'];
    $lastName = $_POST['last_name'];
    $age = $_POST['age'];
    
    $imageName = $_FILES['image']['name'];
    $imageNameTmp = $_FILES['image']['tmp_name'];
    $destination = "images/".$imageName;
    $extension = pathinfo($imageName, PATHINFO_EXTENSION);

    if (empty($imageName)) {
        $imageErr = "Empty image";
    } else {
        $allowedExtensions = ["png", "jpg"];
        if (!in_array($extension, $allowedExtensions)) {
            $imageErr = "Invalid Extension";
        }
    }
    if (empty($firstName)) {
        $firstNameErr = "Empty first name";
    }
    if (empty($lastName)) {
        $lastNameErr = "Empty last name";
    }
    if (empty($age)) {
        $ageErr = "Empty age";
    }

    if (empty($firstNameErr) && empty($lastNameErr) && empty($ageErr) && empty($imageErr)) {
        if (move_uploaded_file($imageNameTmp, $destination)) {
            $query = $pdo->prepare("INSERT INTO student (first_name, last_name, age, image) VALUES (:fname, :lname, :age, :image)");
            $query->bindParam("fname", $firstName);
            $query->bindParam("lname", $lastName);
            $query->bindParam("age", $age);
            $query->bindParam("image", $destination);
            $query->execute();
        } else {
            $imageErr = "Error uploading file";
        }
    }
} else if (isset($_POST['updateStudent'])) {
    $firstName = $_POST['first_name'];
    $lastName = $_POST['last_name'];
    $age = $_POST['age'];
    $std_id = $_GET['std_id'];
    $query = $pdo->prepare("UPDATE student SET first_name = :fname, last_name = :lname, age = :age WHERE std_id = :std_id");
    if (!empty($_FILES['image']['name'])) {
        $imageName = $_FILES['image']['name'];
        $imageNameTmp = $_FILES['image']['tmp_name'];
        $destination = "images/".$imageName;
        $extension = pathinfo($imageName, PATHINFO_EXTENSION);
        if (move_uploaded_file($imageNameTmp, $destination)) {
            $query = $pdo->prepare("UPDATE student SET first_name = :fname, last_name = :lname, age = :age, image = :image WHERE std_id = :std_id");
            $query->bindParam('std_id', $std_id);
            $query->bindParam("fname", $firstName);
            $query->bindParam("lname", $lastName);
            $query->bindParam("age", $age);
            $query->bindParam("image", $destination);
            $query->execute();
        } else {
            $imageErr = "Error uploading file";
        }
    } else {
        $query->bindParam('std_id', $std_id);
        $query->bindParam('fname', $firstName);
        $query->bindParam('lname', $lastName);
        $query->bindParam('age', $age);
        $query->execute();
    }
    echo "<script>location.assign('select.php')</script>";
} else if (isset($_GET['d_std_id'])) {
    $std_id = $_GET['d_std_id'];
    $query = $pdo->prepare("DELETE FROM student WHERE std_id = :std_id");
    $query->bindParam('std_id', $std_id);
    $query->execute();
    echo "<script>location.assign('select.php')</script>";
}

?>
