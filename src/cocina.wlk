import comidas.*
import comensales.*

object cocina {
	var property comidas = []
	
	method tieneBuenaOfertaVegetariana() {
		return if (self.comidasVegetarianas().size() < 2) { false } 
		else { ( self.comidasNoVegetarianas().size() - self.comidasVegetarianas().size() ) <= 2 }
	}
	
	method platoFuerteCarnivoro() { return self.comidasNoVegetarianas().max( { c=>c.valoracion()} ) }
	
	method comidasVegetarianas() { return comidas.filter( { c=>c.esAptoVegetariano() } ) }
	method comidasNoVegetarianas() { return comidas.filter( { c=> not c.esAptoVegetariano() } ) }
	
	method listaDeComidasQueLeGustanA(unComensal) {
		return comidas.filter( { c=>c.leGustaA(unComensal) } )
	}
	

	method elegirPlatoParaComensal(unComensal) {
		if (self.listaDeComidasQueLeGustanA(unComensal).isEmpty()) {
			self.error("Al comensal no le gusta ningun plato de la cocina")
		} 
		else { 
			const platoAlAzar = self.listaDeComidasQueLeGustanA(unComensal).anyOne()
			unComensal.comer(platoAlAzar)
			comidas.remove(platoAlAzar)
		}
	}
	
}