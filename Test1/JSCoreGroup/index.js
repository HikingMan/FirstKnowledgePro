

var factorial = function(n){
    
    if(n < 0){
        
        return;
    }else if(n === 0){
        
        return 1;
    }
    return n * factorial(n-1);
}


var colorMap = {
    
    "red": {"red":255.0, "green":0, "blue":0},
    
    "orange": {"red":255.0, "green":153.0, "blue":0},
    
    "purple": {"red":153.0, "green":0, "blue":153},
    
};

//var resultColor = getColor("orange");
//
//function getColor(word){
//
//    if(!colorMap[word]){
//
//        return;
//    }
//    return makeNSColor(colorMap[word]);
//}


function showStuInfo(name,age,grades){
    
    var student = Student.getStudentWithNameAgeGrades(name,age,grades);
    var infoStr = student.description();

    console.log('JS Student Info' + infoStr);
    return infoStr;
}


var first = "aaa";

manager("bbb");
