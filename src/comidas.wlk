

class Comida {
	method peso()
	method valoracion()
	method esAptoVegetariano()	
	method esAbundante() { return self.peso() > 250 }
	method leGustaA(unComensal) { return unComensal.leAgrada(self) }
}

class Provoleta inherits Comida {
	var property tieneEspecias = false
	var property peso = 0
	
	override method esAptoVegetariano() { return not self.tieneEspecias() }
	
	method esEspecial() { return self.esAbundante() or self.tieneEspecias() }
	
	override method valoracion() { 
		return if (self.esEspecial()) { 120 }
			else { 80 }
	}
	
}

class HamburguesaDeCarne inherits Comida {
	const property pan = panIndustrial
	
	override method peso() { return 250 }

	override method esAptoVegetariano()	{ return false }

	override method valoracion() { return 60 + self.pan().valoracion() }	
	
}

class HamburguesaVegetariana inherits HamburguesaDeCarne {
	const property legumbre = "lentejas" // posibles "lentejas" y "garbanzos"
	
	override method esAptoVegetariano()	{ return true }
	
	override method valoracion() { 
		return super() + (2 * self.cantLetrasLegumbre()).min(17)
	}	
	
	method cantLetrasLegumbre() { return self.legumbre().size() }
}

class Parrillada inherits Comida {
	var property cortes = #{}
	
	override method peso() { return cortes.sum( { c=>c.peso() } ) }
	
	override method esAptoVegetariano()	= false
	
	override method valoracion() { 
		return (( 15 * self.maxCalidadCorte() ) - cortes.size()).max(0)
	}
	
	method maxCalidadCorte() { return self.calidadDeCortes().max() }
	method calidadDeCortes() { return cortes.map( { c=>c.calidad() } ) }
}

class Corte {
	var property calidad = 0
	var property peso = 0
	var property nombre
	
}


object asado  { }
object vacio  { }
object matambreDeCerdo  { }
object entrania { }
object chorizo { }

object panIndustrial {
	method valoracion() = 0
}

object panCasero {
	method valoracion() = 20	
}

object panDeMasaMadre {
	method valoracion() = 45	
}

