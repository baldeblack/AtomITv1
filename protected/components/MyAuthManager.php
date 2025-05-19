<?php

class MyAuthManager extends CDbAuthManager
{
    public $itemTable = 'authitem';
    public $itemChildTable = 'authitemchild';
    public $assignmentTable = 'authassignment';
}