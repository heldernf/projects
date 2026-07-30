let loading
let spinner
function startLoad() {
  if (loading) { return }
  loading = true
  
  spinner = new Spinner({
    lines: 11, length: 0, width: 8, radius: 14, rotate: 0,
    color: '#fff', speed: 1.5, trail: 60, shadow: false,
  }).spin();
}

function stopLoad() {
  spinner && spinner.stop()
  loading = false
}

function openUI(data) {
  $("body").css("display", "flex");

  if (data.isImpound) {
    $("#depotName").html("Impound");
    $(".ImpoundText > p").html("€" + data.priceToSpawn);
    $(".ImpoundMenu").css("display", "block");
  } else {
    $("#depotName").html("Garage");
  }
}

const modePriority = {
  spawn: 1,
  track: 2,
  recover: 3,
  fine: 4,
  notFound: 5,
};
function refreshVehiclesList() {
  $(".garage-cars").empty();

  vehicles.sort((a, b) => modePriority[a.vehicleMode] - modePriority[b.vehicleMode]);
  vehicles.forEach((data, index) => {
    data.vehicleNuiId = index;
    $(".garage-cars").append(`
      <div id="vehicleListed${index}" onclick="selectVehicle('${index}')" class="garage-car" data-vehicle-nui-id="${index}">
        <div class="garage-car-icon" style="background-image: url('./img/vehicleModes/${data.vehicleMode}.svg')"></div>
        <t>${data.carLabel}</t>
      </div>
    `);
  });
}

let vehicles = []
function addVehicleToUI(data) {
  delete data.action
  vehicles.push(data)
  refreshVehiclesList()
}

let nuiIdCurentVehicleShowed
function closeUI() {
  if (loading) { return }
  vehicles = []
  nuiIdCurentVehicleShowed = undefined
  $("body").css("display", "none");
  $(".garage-cars").empty();

  $(".right-side").css("display", "none")
  $(".plate-area").css("display", "none")

  $.post(`https://${GetParentResourceName()}/ClosedUI`, JSON.stringify());
}

$(document).on("keydown", function(event) {
  switch (event.keyCode) {
    case 27: // ESC
      closeUI();
  }
});

function spawnVehicle(vehicleNuiId) {
  const selectedVehicle = vehicles[vehicleNuiId]
  $.post(`https://${GetParentResourceName()}/SpawnVehicle`, JSON.stringify(selectedVehicle), function(success) {
    stopLoad()
    success && closeUI();
  })
}

function updateIndicatorVehicleMode(vehicle) {
  $(`#vehicleListed${vehicle.vehicleNuiId} > .garage-car-icon`).css('background-image', `url('./img/vehicleModes/${vehicle.vehicleMode}.svg')`)
  refreshVehiclesList()
}

function updateVehicleCSS(currentVehicle, lastVehicle) {
  $(`#vehicleListed${currentVehicle.vehicleNuiId}`).css({
    "border-right": ".5rem solid #0ebd5c",
    "background-color": "rgb(88, 88, 88)",
    "opacity": ".8",
  })

  if (lastVehicle) {
    $(`#vehicleListed${lastVehicle.vehicleNuiId}`).css({
      "border-right": "none",
      "background-color": "rgba(88, 88, 88, 0.452)",
      "opacity": ".6",
    })
  }
}

let beforeVehicleShowed
const vehicleModesHandler = {
  spawn: function(selectedVehicle) {
    if (nuiIdCurentVehicleShowed == selectedVehicle.vehicleNuiId) { return }
    nuiIdCurentVehicleShowed = selectedVehicle.vehicleNuiId

    $.post(`https://${GetParentResourceName()}/ShowVehicle`, JSON.stringify(selectedVehicle), function(success) {
      $("#targetIdTotransfer").val("")
      
      if (!success) { return }
      
      beforeVehicleShowed != undefined && $(`#vehicleListed${beforeVehicleShowed.vehicleNuiId}`).removeClass('current-selected-vehicle')
      $(`#vehicleListed${selectedVehicle.vehicleNuiId}`).addClass('current-selected-vehicle')
      $(".right-side").css("display") == "none" && $(".right-side").css("display", "block")

      $(".plate-area").css("display") == "none" && $(".plate-area").css("display", "block")
      $(".plate-text").html(selectedVehicle.carLabel);
      $(".plate-img-box > p").html(selectedVehicle.vehicle.plate);

      $(".drive").attr("onclick", `spawnVehicle("${selectedVehicle.vehicleNuiId}")`);
  
      updateVehicleCSS(selectedVehicle, beforeVehicleShowed)
      beforeVehicleShowed = selectedVehicle

      $(".engine").text(`${selectedVehicle.vehicle.engineHealth * 100 / 1000}%`)
      $(".enginebar > div").css("width", `${selectedVehicle.vehicle.engineHealth * 100 / 1000}%`)
    
      $(".fuel").text(`${selectedVehicle.vehicle.fuelLevel}%`)
      $(".fuelbar > div").css("width", `${selectedVehicle.vehicle.fuelLevel}%`)
    });
  },
  recover: function(selectedVehicle) {
    $.post(`https://${GetParentResourceName()}/RecoverVehicle`, JSON.stringify(selectedVehicle), function(newVehicleMode) {
      if (!newVehicleMode) { return }
      vehicles[selectedVehicle.vehicleNuiId].vehicleMode = newVehicleMode
      updateIndicatorVehicleMode(vehicles[selectedVehicle.vehicleNuiId])

      newVehicleMode == "spawn" && selectVehicle(selectedVehicle.vehicleNuiId)
    })
  },
  track: function(selectedVehicle) {
    $.post(`https://${GetParentResourceName()}/TrackVehicle`, JSON.stringify(selectedVehicle.vehicle.plate), function(data) {
      (data.result && typeof data.result != "string") ? toastr.success(data.message, "Sucesso") : toastr.error(data.message, "Erro")

      if (typeof data.result == "string") {
        vehicles[selectedVehicle.vehicleNuiId].vehicleMode = data.result
        updateIndicatorVehicleMode(vehicles[selectedVehicle.vehicleNuiId])
      }
    })
  },
  fine: function(selectedVehicle) {
    $.post(`https://${GetParentResourceName()}/FineVehicle`, JSON.stringify(), function(data) {
      toastr.error(data.message, "Erro")
    })
  },
  notFound: function(selectedVehicle) {
    $.post(`https://${GetParentResourceName()}/NotFoundVehicle`, JSON.stringify(selectedVehicle.vehicle.model), function(data) {
      toastr.error(data.message, "Erro")
    })
  }
}

function selectVehicle(vehicleNuiId) {
  const selectedVehicle = vehicles[vehicleNuiId]
  vehicleModesHandler[selectedVehicle.vehicleMode](selectedVehicle)
}

function transferVehicle() {
  const targetId = Number($("#targetIdTotransfer").val())

  // TODO: o ID máximo tem ser com base se o player existe ou não, então essa parte deve ser passada para o lua
  if (targetId <= 0 || targetId >= 10000) {
    // CHANGE
    toastr.error("Identificación inválida", "Erro")
    return
  }

  const vehicleNuiId = $(".current-selected-vehicle").data("vehicle-nui-id")
  const selectedVehicle = vehicles[vehicleNuiId]

  $.post(`https://${GetParentResourceName()}/TransferVehicle`, JSON.stringify({
    targetId: targetId, vehicle:{plate: selectedVehicle.vehicle.plate, label: selectedVehicle.carLabel}
  }), function(data) {
    data.message && data.canTransfer ? toastr.success(data.message, "Sucesso") : (data.message && !data.canTransfer) && toastr.error(data.message, "Erro")
    if (data.canTransfer) { 
      $(`#${vehicleNuiId}`).remove()
      $(".right-side").css("display", "none")
      $(".plate-area").css("display", "none")
    }

    stopLoad()
  })
}

addEventListener("message", function(event) {
  let data = event.data;
  
  if (data.action == "openUI") {
    openUI(data)
  } else if (data.action == "addVehicleToUI") {
    addVehicleToUI(data)
  } else if (data.action == "startLoad") {
    startLoad()
  }
})