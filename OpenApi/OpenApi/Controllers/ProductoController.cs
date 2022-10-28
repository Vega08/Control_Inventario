using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using OpenApi.Models;
using System.Data;
using System.Data.SqlClient;




namespace OpenApi.Controllers
{
    [EnableCors("ReglasCors")]
    [Route("api/[controller]")]
    [ApiController]
    public class ProductoController : ControllerBase
    {
        private readonly string _context;

        public ProductoController(IConfiguration config)
        {
            _context = config.GetConnectionString("ControlClienteSQL");
        }

        //Consultar Todo los productos
        [HttpGet]
        [Route("Lista")]
        public IActionResult Lista()
        {
            List<Producto> list = new List<Producto>();
            try
            {
                using (var conexion = new SqlConnection(_context))
                {
                    conexion.Open();
                    var cmd = new SqlCommand("consultarProductos", conexion);
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            list.Add(new Producto()
                            {
                                id = Convert.ToInt32(rd["id"]),
                                nombrepro = rd["nombrepro"].ToString(),
                                cantidad = Convert.ToInt32(rd["cantidad"]),
                                descripcion = rd["descripcion"].ToString(),
                                precio = Convert.ToDecimal(rd["precio"])
                            });
                        }
                    }
                }
                return StatusCode(StatusCodes.Status200OK, new { mensaje = "ok", response = list });
            }
            catch (Exception error)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { mensaje = error.Message, response = list });
            }
         
        }
        //Registrar Producto 
        [HttpPost]
        [Route("Guardar")]
        public IActionResult Guardar([FromBody]Producto objeto)
        {
            
            try
            {
                using (var conexion = new SqlConnection(_context))
                {
                    conexion.Open();
                    var cmd = new SqlCommand("guardarProducto", conexion);
                    cmd.Parameters.AddWithValue("nombrepro",objeto.nombrepro);
                    cmd.Parameters.AddWithValue("cantidad", objeto.cantidad);
                    cmd.Parameters.AddWithValue("descripcion", objeto.descripcion);
                    cmd.Parameters.AddWithValue("precio", objeto.precio);

                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();
                 
                }
         
                return StatusCode(StatusCodes.Status200OK, new { mensaje = "ok"});
            }
            catch (Exception error)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { mensaje = error.Message });
            }

        }
        //Actualizar Producto 
        [HttpPut]
        [Route("Editar")]
        public IActionResult Editar([FromBody] Producto objeto)
        {

            try
            {
                using (var conexion = new SqlConnection(_context))
                {
                    conexion.Open();
                    var cmd = new SqlCommand("actualizarProducto", conexion);
                    cmd.Parameters.AddWithValue("id", objeto.id == 0 ? DBNull.Value : objeto.id);
                    cmd.Parameters.AddWithValue("nombrepro", objeto.nombrepro);
                    cmd.Parameters.AddWithValue("cantidad", objeto.cantidad);
                    cmd.Parameters.AddWithValue("descripcion", objeto.descripcion);
                    cmd.Parameters.AddWithValue("precio", objeto.precio);

                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();

                }

                return StatusCode(StatusCodes.Status200OK, new { mensaje = "ok" });
            }
            catch (Exception error)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { mensaje = error.Message });
            }

        }

        //Consultar Producto por id
        [HttpGet]
        [Route("Obtener/{id:int}")]
        public IActionResult Obtener(int id)
        {
            List<Producto> list = new List<Producto>();
            Producto producto = new Producto();
            try
            {
                using (var conexion = new SqlConnection(_context))
                {
                    conexion.Open();
                    var cmd = new SqlCommand("consultarProductos", conexion);
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (var rd = cmd.ExecuteReader())
                    {
                        while (rd.Read())
                        {
                            list.Add(new Producto()
                            {
                                id = Convert.ToInt32(rd["id"]),
                                nombrepro = rd["nombrepro"].ToString(),
                                cantidad = Convert.ToInt32(rd["cantidad"]),
                                descripcion = rd["descripcion"].ToString(),
                                precio = Convert.ToDecimal(rd["precio"])
                            });
                        }
                    }
                }
                producto = list.Where(item => item.id == id).FirstOrDefault();
                return StatusCode(StatusCodes.Status200OK, new { mensaje = "ok", response = producto });
            }
            catch (Exception error)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { mensaje = error.Message, response = producto });
            }

        }
        //Eliminar Producto 
        [HttpDelete]
        [Route("Eliminar/{id:int}")]
        public IActionResult Eliminar(int id)
        {

            try
            {
                using (var conexion = new SqlConnection(_context))
                {
                    conexion.Open();
                    var cmd = new SqlCommand("eliminarProducto", conexion);
                    cmd.Parameters.AddWithValue("id", id);
                    

                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.ExecuteNonQuery();

                }

                return StatusCode(StatusCodes.Status200OK, new { mensaje = "Eliminado" });
            }
            catch (Exception error)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new { mensaje = error.Message });
            }

        }

    }
}
