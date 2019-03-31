var data = [
  {
    "name":"Display",
    "group":"Technical detals",
    "id":"60",
    "value":"4"
  },
  {
    "name":"Manufacturer",
    "group":"Manufacturer",
    "id":"58",
    "value":"Apple"
  },
  {
    "name":"OS",
    "group":"Technical detals",
    "id":"37",
    "value":"Apple iOS"
  },
  {
    "name":"OS",
    "group":"Hardware",
    "id":"37",
    "value":"Apple iOS"
  }
]

var groups = _.groupBy(data, 'group');
//console.log(groups)

var groups2 = { };
data.forEach(function(item){
		console.log(item);
    var list = groups2[item.group];  
    if(list){
        list.push(item);
    } else{
       groups2[item.group] = [item];
    }
});

console.log(groups2);
