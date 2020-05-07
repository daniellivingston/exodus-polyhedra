# Example Output

Use **ncdump** to write ASCII files of the Exodus binary files. Note these ASCII files are not readable by VIS applications but provide information about the mesh.

Commands to write ASCII versions of these files:

<pre>
 ../seacas/bin/ncdump four_polygon.exo > four_polygon.exo.ascii.txt
 ../seacas/bin/ncdump basic_ats_example.exo > basic_ats_example.exo.ascii.txt
</pre>

## Mesh Description

In general a mesh is made up of elements with a expected number of vertices (nodes) that create that element, ie a tetrahedral is defined by 4 connected vertices each at an xyz location.
The polydedra element is represented by a variable number of faces which can be 2D arbitrary polygons consisting of a list of vertices.


For Exodus polyhedra see: https://gsjaardema.github.io/seacas/html/polyhedra.html


For Exodus documentation: https://gsjaardema.github.io/seacas/exodusII-new.pdf


### Exodus Header

The first line gives the root file name followed by the header.
This provides important summary information about the mesh and is the first thing that should be checked for correctness.

This mesh has 132 nodes (vertices), 40 elements, the polyhedra element block has an element type of  "NFACED".

The faces that are used in the connectivity of the polyhedra element block are defined in a face block and has a face type of "NSIDED".

There is 1 element block, this is the region or material. The element block 1 (eb_prop1) has a value of 10000. Note we usually start materials with a value of 1, Amanzi/ATS adds zeros for their own debugging methods.


There are 3 side sets (sets of faces on boundary).
ss1 = 4 faces at bottom
ss2 = 4 faces at top surface
ss3 = 110 side boundary faces

### Dimensions

This is the first entry in the file and lists the sizes of data arrays in this mesh.

<pre>
netcdf four_polygon {
dimensions:
	len_name = 256 ;
	time_step = UNLIMITED ; // (0 currently)
	num_dim = 3 ;
	num_nodes = 132 ;
	num_elem = 40 ;
	num_face = 194 ;
	num_el_blk = 1 ;
	num_fa_blk = 1 ;
	num_side_sets = 3 ;
	num_fa_in_blk1 = 194 ;
	num_nod_per_fa1 = 809 ;
	num_el_in_blk1 = 40 ;
	num_fac_per_el1 = 270 ;
	num_side_ss1 = 4 ;
	num_side_ss2 = 4 ;
	num_side_ss3 = 110 ;

</pre>


### Variables

These are the data arrays holding mesh attributes with length based on the attribute type such as node, face, element, or side set (face set).

<pre>
variables:
	double time_whole(time_step) ;
	int eb_status(num_el_blk) ;
	int eb_prop1(num_el_blk) ;
		eb_prop1:name = "ID" ;
	int fa_status(num_fa_blk) ;
	int fa_prop1(num_fa_blk) ;
		fa_prop1:name = "ID" ;
	int ss_status(num_side_sets) ;
	int ss_prop1(num_side_sets) ;
		ss_prop1:name = "ID" ;
	double coordx(num_nodes) ;
	double coordy(num_nodes) ;
	double coordz(num_nodes) ;
	char eb_names(num_el_blk, len_name) ;
		eb_names:_FillValue = "" ;
	char fa_names(num_fa_blk, len_name) ;
		fa_names:_FillValue = "" ;
	char ss_names(num_side_sets, len_name) ;
		ss_names:_FillValue = "" ;
	char coor_names(num_dim, len_name) ;
		coor_names:_FillValue = "" ;
	int fbconn1(num_nod_per_fa1) ;
		fbconn1:elem_type = "NSIDED" ;
	int fbepecnt1(num_fa_in_blk1) ;
		fbepecnt1:entity_type1 = "NODE" ;
		fbepecnt1:entity_type2 = "FACE" ;
	int facconn1(num_fac_per_el1) ;
		facconn1:elem_type = "NFACED" ;
	int ebepecnt1(num_el_in_blk1) ;
		ebepecnt1:entity_type1 = "FACE" ;
		ebepecnt1:entity_type2 = "ELEM" ;
	int elem_ss1(num_side_ss1) ;
	int side_ss1(num_side_ss1) ;
	int elem_ss2(num_side_ss2) ;
	int side_ss2(num_side_ss2) ;
	int elem_ss3(num_side_ss3) ;
	int side_ss3(num_side_ss3) ;

</pre>

### Data

These are the data arrays for the mesh. They include the vertices with implied order 1 to N giving coordx, coordy, then coordz. The coordinates are followed by connectivity lists for the faces and the elements.

If they exist, the side sets are written. First the elements on that boundary are listed, and then the list of faces with the nth face of that element that is on a boundary.

