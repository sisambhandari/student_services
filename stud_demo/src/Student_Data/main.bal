//import ballerina/io;
import ballerinax/java.jdbc;
import ballerina/io;
//import ballerina/http;

const string male = "MALE";
const string female = "FEMALE";

public type Person record {
    string name_with_initials;
    string fullname; 
    //int date_of_birth;  //ddmmyy
    //male | female gender;  //m or f
    //string address; 
    //int nic_number;
};

public type Student_Details record {
    *Person;
    //string religion; 
    //string ethnicity; 
    //string grade_and_class; 
    //string birth_district; 
    //string  birth_registrar_division; 
    //int birth_certificate_number; 
    //string special_need_difficulty; 
    //boolean pre_school;  //yes(1) or no(0)
    //string pre_school_type; //if preschool ==1 : gov or private 
    //float weight; //in kg
    //float height; //in cm 
    //int admission_number; 
};

public type Father_Details record {
    *Person;
    //int postal_code; 
    //string address_ds_division;
    //int contact_number; 
};

//public type Mother_Details record {
//    *Person; 
    //int postal_code; 
    //string address_ds_division;
    //int contact_number; 
//};

//public type Guardian_Details record { 
//    *Person; 
    //int postal_code; 
    //string address_ds_division;
    //int contact_number; 
//}; 

jdbc:Client testDB = new({
    url: "jdbc:h2:file:./db_files/demodb",
    username: "test",
    password: "test",
    poolOptions: {maximumPoolSize : 5}
});

public function main() { 
    // Create the table.
    var ret = testDB->update("CREATE TABLE STUDENT_DETAILS (FULLNAME VARCHAR(30), NAME_WITH_INITIALS VARCHAR(30))");
    handleUpdate(ret, "Table STUDENT_DETAILS creation");
}

public function createDB(Student_Details stud) {
    var ret = testDB->update("CREATE TABLE STUDENT_DETAILS (FULLNAME VARCHAR(30), NAME_WITH_INITIALS VARCHAR(30))");
    handleUpdate(ret, "Table STUDENT_DETAILS creation");

    ret = testDB->update("INSERT INTO STUDENT_DETAILS (FULLNAME, NAME_WITH_INITIALS) VALUES (?, ?)", stud.fullname, stud.name_with_initials);
    handleUpdate(ret, "Insert data to STUDENT_DETAILS table");

    // Retrieving data from table.
    //var selectRet = testDB->select("SELECT id,fullname FROM CUSTOMER WHERE nic_number < ??", Student_Details, nic_number );
    //if (selectRet is table<Student_Details>) {
    //    foreach var row in selectRet {
    //        io:println(row);
    //    }
    //}
    
}



// Function to handle the return value of the `update` remote function.
public function handleUpdate(jdbc:UpdateResult|error returned, string message) {
    if (returned is jdbc:UpdateResult) {
        io:println(message + " status: ", returned.updatedRowCount);
    } else {
        io:println(message + " failed: ", <string>returned.detail()?.message);
    }
}





