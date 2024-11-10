class Actividad{
  const property idiomas = {}
  method implicaEsfuerzo ()
  method broncearse ()
  method cuantosDias ()
  method esInteresante() = idiomas.size() > 2

  method esRecomendada(unSocio) = self.esInteresante() and unSocio.leAtrae(self) and !unSocio.actividadesRealizadas().contains(self)
}

class ViajesDePlaya inherits Actividad{
  var largo

  method largo() = largo
  override method cuantosDias() = largo/500
  override method implicaEsfuerzo() = largo > 1200
  override method broncearse() = true
}

class ExcursionACiudad inherits Actividad{
  var property atracciones
  
  override method cuantosDias() = atracciones / 2 
  override method implicaEsfuerzo() = atracciones.between(5, 8)
  override method broncearse() = false
  override method esInteresante() = super() or atracciones == 5
}

  class ExcursionTropical inherits ExcursionACiudad {
    override method cuantosDias() = super() + 1
    override method broncearse() = true
  }

  class SalidasDeTrekking inherits Actividad{
    const kilometrosDeSendero
    const diasDeSol

    method kilometrosDeSendero() = kilometrosDeSendero
    method diasDeSol() = diasDeSol
    override method cuantosDias() = kilometrosDeSendero / 50
    override method implicaEsfuerzo() = kilometrosDeSendero > 80
    override method broncearse() = diasDeSol > 200 or self.condicionParaBroncearse()

    method condicionParaBroncearse() = diasDeSol.between(100, 200) and kilometrosDeSendero > 120

    override method esInteresante() = super() and diasDeSol > 140
  }

  class ClasesDeGimnasia inherits Actividad {
    method initialize(){
      idiomas.clear()
      idiomas.add("espaniol")
        if(idiomas!=["espaniol"]) self.error("solo se permite clase de gimnasia en espaniol")
    }
    override method cuantosDias() = 1
    override method implicaEsfuerzo() = true
    override method broncearse() = false
    override method esRecomendada(unSocio) = unSocio.edad().between(20, 30)
  }

  class Socios {
    const property actividadesRealizadas = []
    const property maximoDeActividades
    var edad
    const property idiomas = {}

    method edad() = edad
    method idiomas() = idiomas
    method adoradorDelSol() = actividadesRealizadas.all({a => a.broncearse()})
    method actividadesEsforzadas() = actividadesRealizadas.filter({a => a.implicaEsfuerzo()})

    method registrarActividad(unaActividad) {
      if(maximoDeActividades == actividadesRealizadas.size()){
        self.error("Ya llego a el maximo de actividades")
      }
      actividadesRealizadas.add(unaActividad)
    }
    method leAtrae(unaActividad)
  }

  class SociosTranquilos inherits Socios {
    override method leAtrae(unaActividad) = unaActividad.cuantosDias() >= 4
  }

  class SociosCoherentes inherits Socios {
    override method leAtrae(unaActividad) =
      if(self.adoradorDelSol()){
        unaActividad.broncearse()
      }
      else{
      unaActividad.implicaEsfuerzo()
    }
  }

  class SociosRelajado inherits Socios {
    override method leAtrae(unaActividad) = !idiomas.intersection(unaActividad.idiomas()).isEmpty()
  }

  class TalleresLiterarios inherits Actividad {
    const property libros = []

    method initialize() {
      idiomas.clear()
      idiomas.addAll(libros.map({l => l.idioma()}))
    }

    override method cuantosDias() = libros.size() + 1
    override method implicaEsfuerzo() = libros.any({l => l.paginas() > 500}) or libros.size() > 1 and libros.map({l => l.autor()}).asSet().size() == 1
    override method broncearse() = false
    override method esRecomendada(unSocio) = unSocio.idiomas().size() > 1
  }

  class libros{
    const property idioma
    const property paginas
    const property autor 
  }