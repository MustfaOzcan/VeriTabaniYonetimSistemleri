using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
namespace VTYS_PROJE1
{
   

    public partial class Yemekler : Form
    {
       
        public Yemekler()
        {
            InitializeComponent();
        }

      
        NpgsqlConnection baglanti = new NpgsqlConnection("server=localHost;port=5432;Database=Proje1_Yedek;userID=postgres; password=123456");
        //LISTELE
        public void btn_listele_Click(object sender, EventArgs e)
        {
            //listeleme
            string sorgu = "SELECT * FROM tbl_yemek order by yemek_id ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            
           DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;

            //DataSet ds = new DataSet();
            //da.Fill(ds);
            //dataGridView1.DataSource = ds.Tables[0];
            

        }
        //FORM'
        private void btn_form2_Click(object sender, EventArgs e)
        {
            Form2 ff = new Form2();
            ff.Show();
        }

        //EKLE
        private void btn_ekle_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut1 = new NpgsqlCommand("insert into tbl_yemek (yemek_id,lokanta_id,personel_id,yemek_ad,yemek_fiyat,yemek_stok,yemek_kalori) values(@p1,@p2,@p3,@p4,@p5,@p6,@p7)", baglanti);
            komut1.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));//int
            komut1.Parameters.AddWithValue("@p2", int.Parse(txt_lokanta_id.Text));
            komut1.Parameters.AddWithValue("@p3", int.Parse(txt_personel_id.Text));
            komut1.Parameters.AddWithValue("@p4", txt_yemekad.Text);
            komut1.Parameters.AddWithValue("@p5", int.Parse(txt_yemek_fiyat.Text));
            komut1.Parameters.AddWithValue("@p6", int.Parse(txt_yemekstok.Text));
            komut1.Parameters.AddWithValue("@p7", int.Parse(txt_yemekkalori.Text));
            komut1.ExecuteNonQuery();//degisikleri veri tabanina yansit
            baglanti.Close();
            MessageBox.Show("Ekleme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM tbl_yemek  ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
            //EKLEME DATAGRID3 LİSTELEDİK 
            string sorgu3 = "SELECT * FROM tbl_toplam_yemek";
            NpgsqlDataAdapter da3 = new NpgsqlDataAdapter(sorgu3, baglanti);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
            dataGridView3.DataSource = ds3.Tables[0];



        }
        //FORM YUKLENDIGINDE LISTELENSIN
        private void Form1_Load(object sender, EventArgs e)
        {
            string sorgu = "SELECT * FROM tbl_yemek  ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];

            ///DATAGRID2 TABLOSU
            ///LISTELE
            string sorgu2 = "SELECT * FROM tbl_urunson";
            NpgsqlDataAdapter da2 = new NpgsqlDataAdapter(sorgu2, baglanti);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
            dataGridView2.DataSource = ds2.Tables[0];

            ////DATAGRID VIEV3 TABLOSU 
            ///LISTELE
            ///
            string sorgu3 = "SELECT * FROM tbl_toplam_yemek";
            NpgsqlDataAdapter da3 = new NpgsqlDataAdapter(sorgu3, baglanti);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
            dataGridView3.DataSource = ds3.Tables[0];




        }

        private void btn_sil_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut2 = new NpgsqlCommand("DELETE From tbl_yemek where yemek_id=@p1",baglanti);
            komut2.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));
            komut2.ExecuteNonQuery();
            baglanti.Close();
            MessageBox.Show("Silme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM tbl_yemek  ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
            //SİLME DATAGRİD3 LİSTELEDLİK
            string sorgu3 = "SELECT * FROM tbl_toplam_yemek";
            NpgsqlDataAdapter da3 = new NpgsqlDataAdapter(sorgu3, baglanti);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
            dataGridView3.DataSource = ds3.Tables[0];



        }
        //GUNCELLEME
        private void btn_guncelle_Click(object sender, EventArgs e)
        {
            baglanti.Open();
            NpgsqlCommand komut3= new NpgsqlCommand("UPDATE tbl_yemek SET lokanta_id=@p2,personel_id=@p3,yemek_ad=@p4,yemek_fiyat=@p5,yemek_stok=@p6,yemek_kalori=@p7 WHERE yemek_id=@p1", baglanti);
            komut3.Parameters.AddWithValue("@p1", int.Parse(txt_id.Text));//int
            komut3.Parameters.AddWithValue("@p2", int.Parse(txt_lokanta_id.Text));
            komut3.Parameters.AddWithValue("@p3", int.Parse(txt_personel_id.Text));
            komut3.Parameters.AddWithValue("@p4", txt_yemekad.Text);
            komut3.Parameters.AddWithValue("@p5", int.Parse(txt_yemek_fiyat.Text));
            komut3.Parameters.AddWithValue("@p6", int.Parse(txt_yemekstok.Text));
            komut3.Parameters.AddWithValue("@p7", int.Parse(txt_yemekkalori.Text));
            komut3.ExecuteNonQuery();//degisikleri veri tabanina yansit
            baglanti.Close();
            MessageBox.Show("Güncelleme Başarılı");
            //listeleme
            string sorgu = "SELECT * FROM tbl_yemek  ";
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(sorgu, baglanti);
            DataSet ds = new DataSet();
            da.Fill(ds);
            dataGridView1.DataSource = ds.Tables[0];
            //GUNCELLEME ISLEMI SONRASI DATA GRID2 LISTELENSIN
            string sorgu2 = "SELECT * FROM tbl_urunson";
            NpgsqlDataAdapter da2 = new NpgsqlDataAdapter(sorgu2, baglanti);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
            dataGridView2.DataSource = ds2.Tables[0];



        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

           if(e.RowIndex>=0)
            {
                DataGridViewRow row = this.dataGridView1.Rows[e.RowIndex];

                txt_id.Text = row.Cells["yemek_id"].Value.ToString();
                txt_lokanta_id.Text = row.Cells["lokanta_id"].Value.ToString();
                txt_personel_id.Text = row.Cells["personel_id"].Value.ToString();
                txt_yemekad.Text = row.Cells["yemek_ad"].Value.ToString();
                txt_yemek_fiyat.Text = row.Cells["yemek_fiyat"].Value.ToString();
                txt_yemekstok.Text = row.Cells["yemek_stok"].Value.ToString();
                txt_yemekkalori.Text = row.Cells["yemek_kalori"].Value.ToString();
            }

          
           
        }

        private void btn_listele_dgv2_Click(object sender, EventArgs e)
        {
            string sorgu2 = "SELECT * FROM tbl_urunson";
            NpgsqlDataAdapter da2 = new NpgsqlDataAdapter(sorgu2, baglanti);
            DataSet ds2 = new DataSet();
            da2.Fill(ds2);
            dataGridView2.DataSource = ds2.Tables[0];
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sorgu3 = "SELECT * FROM tbl_toplam_yemek";
            NpgsqlDataAdapter da3 = new NpgsqlDataAdapter(sorgu3, baglanti);
            DataSet ds3 = new DataSet();
            da3.Fill(ds3);
            dataGridView3.DataSource = ds3.Tables[0];
        }

        private void btn_silinenyemek_Click(object sender, EventArgs e)
        {
            Form3 ff = new Form3();
            ff.Show();
        }

       

        
      
    }
    
}
