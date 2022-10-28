package com.ab.springbootinventario.repositorio;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ab.springbootinventario.modelo.Producto;

public interface ProductoRepositorio extends JpaRepository<Producto,Integer> {

}
