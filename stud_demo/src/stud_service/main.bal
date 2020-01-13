import ballerina/http;
import ballerina/io;
import Student_Data; 
listener http:Listener listenerEp = new(9090);

service Dbadd on listenerEp {
    //restriction: only POST request
    @http:ResourceConfig {
        methods: ["POST"]
    }
    resource function newResource(http:Caller caller, http:Request request) {
        map<string>|error form = request.getFormParams(); 
        io:println(form);
        if (form is map<string>){
            Student_Data:Student_Details student_add = {name_with_initials: form.get("studentName"), fullname: form.get("studentFullname")};
            Student_Data:Student_Details father_add = {name_with_initials: form.get("fatherName"), fullname: form.get("fatherFullname") };
            Student_Data:createDB(student_add); 

            io:println(student_add);
        }   
    }
}

