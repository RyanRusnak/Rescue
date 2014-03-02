(function ( $ ) {
  $.fn.restObjectTable = function( options ) {

    // This is the easiest way to have default options.
    var settings = $.extend({
    'model' : null,
		'url' : null,
    'currentUserId' : null,
    'dataCols' : null
    }, options );

    //===================================== vars =======================================//
    var model = settings.model;
    var url = settings.url;
    var currentUserId = settings.currentUserId;
    var dataCols = settings.dataCols;
    var rows = '';
    var that = this;

    //===================================== Functions =======================================//
    function getRowData(row){
      var counter = 0;
      var data = {};
        row.find('input').each(function(){
          data[dataCols[counter]] = $(this).val();
          counter +=1;
        });
        return data;
    }
    function create(row){
      var payload = {};
      payload[model]=getRowData(row);
      $.post('/users/'+ currentUserId + url, payload, function(data){
        row.attr('id',data._id.$oid);
        console.log(data);
      })
      .fail(function(msg) {
        console.log(msg);
      });
    }
    function update(row){
      var payload = {};
      payload[model]=getRowData(row);
      $.ajax({
        type: "PUT",
        url: "/users/" + currentUserId + url + "/" + row.attr('id'),
        data: payload
      })
        .done(function( msg ) {
          console.log(msg);
        });
    }
    function remove(row){
      console.log('in remove');
      $.ajax({
        type: "DELETE",
        url: "/users/" + currentUserId + url + "/" + row.attr('id'),
        dataType : 'json'
      })
        .done(function( msg ) {
          row.remove();
        })
        .fail(function(msg)  {
          console.log('failed');
        });
    }

    $(this).on('click', '.update', function(){
      update($(this).parent().parent());
    });
    $(this).on('click', '.delete', function(){
      remove($(this).parent().parent());
    });
    $(this).on('click', '.create', function(){
      create($(this).parent().parent());
      $(this).parent().html('<button class="update btn">Update</button><button class="delete btn">Delete</button>');
    });
    $(this).on('click', '.add', function(){
      var tds = '';
      for (var j=0; j<dataCols.length; j+=1){
            tds += '<td><input></td>';
        }
      that.find('tbody').append('<tr>'+tds+'<td><button class="create btn">Save</button><button class="remove btn">Remove</button><td></tr>');
    });
    $(this).on('click', '.remove', function(){
      $(this).parent().parent().remove();
    });

    //===================================== Get records =======================================//
    $.get("/users/" + currentUserId + url, function(data){
      for (var i=0; i<data.length; i+=1){
        var tds = '';
        for (var j=0; j<dataCols.length; j+=1){
          if (data[i][dataCols[j]]){
            tds += '<td><input value="'+data[i][dataCols[j]]+'"></td>';
          }else{
            tds += '<td><input></td>';
          }
        }
        rows += '<tr id="'+data[i]['_id'].$oid+'">'+tds+'<td><button class="update btn">Update</button><button class="delete btn">Delete</button><td></tr>';
      }
      var body = '<tbody>'+rows+'</tbody>';
      var table = '<table class="table">'+body+'</table>'+
      '<button class="add btn btn-primary">Add New Pet</button>';

      $(that).html(table);
    });


  };
}( jQuery ));