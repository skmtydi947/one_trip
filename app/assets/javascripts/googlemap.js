var map
var geocoder
var marker = [];
var infoWindow = [];
var markerData = gon.post; // コントローラーで定義したインスタンス変数を変数に代入
var spot = gon.posts;
var post_location = [];
var post_lat = [];
var post_lng = [];

// GoogleMapを表示する関数(callback処理で呼び出される)
function initMap(){
  geocoder = new google.maps.Geocoder()
  // ビューのid='map_index'の部分にGoogleMapを埋め込む
  map = new google.maps.Map(document.getElementById('map_index'), {
    center: { lat: markerData.latitude, lng: markerData.longitude }, // 投稿された時の経度・緯度を設定
    zoom: 9,
  });

  

  // 繰り返し処理でマーカーと吹き出しを複数表示させる
  for (var i = 0; i < spot.length; i++) {
    // 各地点の緯度経度を算出
    markerLatLng = new google.maps.LatLng({
      lat: spot[i]['latitude'],
      lng: spot[i]['longitude']
    });

    // マーカーの表示
    marker[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map
    });

    // 吹き出しの表示
    let id = spot[i]['id']
    post_location[i]= spot[i]['location'];
    post_lat[i]= spot[i]['latitude'];
    post_lng[i]= spot[i]['longitude'];
    infoWindow[i] = new google.maps.InfoWindow({
      // 吹き出しの中身, 引数で各属性の配列と配列番号を渡す
      content: `<a href='/posts/${ id }'>${ spot[i]['location'] }</a><input type="button" value="追加" onclick="addPost(post_location, post_lat, post_lng, ${i})">`
    });
    markerEvent(i);
  }
}

// マーカーをクリックしたら吹き出しを表示
function markerEvent(i) {
  marker[i].addListener('click', function () {
    infoWindow[i].open(map, marker[i]);
  });
}


// リストに追加する
function addPost(location, lat, lng, number){
  var li = $('<li>', {
    text: location[number],
    "class": "list-group-item"
  });
  li.attr("data-lat", lat[number]); // data-latという属性にlat[number]を入れる
  li.attr("data-lng", lng[number]); // data-lngという属性にlng[number]を入れる
  $('#route-list').append(li); // idがroute-listの要素の一番後ろにliを追加
}

// ルートを検索する
function search() {
  var points = $('#route-list li');

  // 2地点以上のとき
  if (points.length >= 2){
      var origin; // 開始地点
      var destination; // 終了地点
      var waypoints = []; // 経由地点

      // origin, destination, waypointsを設定する
      for (var i = 0; i < points.length; i++) {
          points[i] = new google.maps.LatLng($(points[i]).attr("data-lat"), $(points[i]).attr("data-lng"));
          if (i == 0){
            origin = points[i];
          } else if (i == points.length-1){
            destination = points[i];
          } else {
            waypoints.push({ location: points[i], stopover: true });
          }
      }
      // リクエストの作成
      var request = {
        origin:      origin,
        destination: destination,
        waypoints: waypoints,
        travelMode:  google.maps.TravelMode.DRIVING
      };
      // ルートサービスのリクエスト
      new google.maps.DirectionsService().route(request, function(response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
          new google.maps.DirectionsRenderer({
            map: map,
            suppressMarkers : true,
            polylineOptions: { // 描画される線についての設定
              strokeColor: '#00ffdd',
              strokeOpacity: 1,
              strokeWeight: 5
            }
          }).setDirections(response);//ライン描画部分

            // 距離、時間を表示する
            var data = response.routes[0].legs;
            for (var i = 0; i < data.length; i++) {
                // 距離
                var li = $('<li>', {
                  text: data[i].distance.text,
                  "class": "display-group-item"
                });
                $('#display-list').append(li);

                // 時間
                var li = $('<li>', {
                  text: data[i].duration.text,
                  "class": "display-group-item"
                });
                $('#display-list').append(li);
            }
            const route = response.routes[0];
            // ビューのid='directions-panel'の部分に埋め込む
            const summaryPanel = document.getElementById("directions-panel");
            summaryPanel.innerHTML = "";

            // 各地点間の距離・時間を表示
            for (let i = 0; i < route.legs.length; i++) {
              const routeSegment = i + 1;
              summaryPanel.innerHTML +=
                "<b>区間: " + routeSegment + "</b><br>";
              summaryPanel.innerHTML += route.legs[i].start_address + "<br>" + " ↓ " + "<br>";
              summaryPanel.innerHTML += route.legs[i].end_address + "<br>";
              summaryPanel.innerHTML += "<" + route.legs[i].distance.text + ",";
              summaryPanel.innerHTML += route.legs[i].duration.text + ">" + "<br>";
            }
        }
      });
  }
}