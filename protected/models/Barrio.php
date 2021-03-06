<?php

/**
 * This is the model class for table "barrio".
 *
 * The followings are the available columns in table 'barrio':
 * @property integer $id
 * @property string $nombre
 * @property integer $id_ciudad
 * @property integer $id_departamento
 *
 * The followings are the available model relations:
 * @property Ciudad $idCiudad
 * @property Departamento $idDepartamento
 */
class Barrio extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
	public function tableName()
	{
		return 'barrio';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			array('nombre','required'),
			array('id_ciudad, id_departamento', 'numerical', 'integerOnly'=>true),
			array('nombre', 'length', 'max'=>30),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, nombre, id_ciudad, id_departamento', 'safe', 'on'=>'search'),
		);
	}

	/**
	 * @return array relational rules.
	 */
	public function relations()
	{
		// NOTE: you may need to adjust the relation name and the related
		// class name for the relations automatically generated below.
		return array(
			'ciudad' => array(self::BELONGS_TO, 'Ciudad', 'id_ciudad'),
			'departamento' => array(self::BELONGS_TO, 'Departamento', 'id_departamento'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'nombre' => 'Nombre',
			'id_ciudad' => 'Ciudad',
			'id_departamento' => 'Departamento',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('nombre',$this->nombre,true);
		$criteria->compare('id_ciudad',$this->id_ciudad);
		$criteria->compare('id_departamento',$this->id_departamento);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}


	public function getMenuDepartamentos(){
		$departamentos=Departamento::model()->findAll();
		return CHtml::listData($departamentos, 'id','nombre');
	}

	public function getMenuCuidades($defaultDepartamento=1){
		 return CHtml::listData(Ciudad::model()->findAll('id_departamento=?',array($defaultDepartamento)), 'id','nombre');
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Barrio the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
}
